// @dart=2.9
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:finpro_max_admin/bloc/profile/bloc.dart';
import 'package:finpro_max_admin/models/user.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:meta/meta.dart';

// START OF PROFILE SETUP 04 16/41 //
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AdminRepository _adminRepository;

  ProfileBloc({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository;

  @override
  // implement initialState
  ProfileState get initialState => ProfileInitialState(); // ProfileState.empty

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileLoadedEvent) {
      yield* _mapProfileLoaded(adminId: event.adminId);
    }
  }

  Stream<ProfileState> _mapProfileLoaded({String adminId}) async* {
    yield ProfileLoadingState();
    Admin currentAdmin = await _adminRepository.getProfile(adminId);
    yield ProfileLoadedState(currentAdmin);
  }
}
