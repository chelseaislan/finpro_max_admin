// @dart=2.9
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AdminRepository _adminRepository;

  AuthenticationBloc({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStarted();
    } else if (event is LoggedIn) {
      yield* _mapLoggedIn();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOut();
    }
  }

  Stream<AuthenticationState> _mapAppStarted() async* {
    try {
      final isSignedIn = await _adminRepository.isSignedIn();
      if (isSignedIn) {
        final uid = await _adminRepository.getAdmin();
        final isFirstTime = await _adminRepository.isFirstTime(uid);

        if (!isFirstTime) {
          yield AuthenticatedButNotSet(adminId: uid);
        } else {
          yield Authenticated(adminId: uid);
        }
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedIn() async* {
    final isFirstTime =
        await _adminRepository.isFirstTime(await _adminRepository.getAdmin());

    if (!isFirstTime) {
      yield AuthenticatedButNotSet(adminId: await _adminRepository.getAdmin());
    } else {
      yield Authenticated(adminId: await _adminRepository.getAdmin());
    }
  }

  Stream<AuthenticationState> _mapLoggedOut() async* {
    yield Unauthenticated();
    _adminRepository.signOut();
  }
}
