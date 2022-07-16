// @dart=2.9
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:finpro_max_admin/repositories/admin_repository.dart';
import 'package:finpro_max_admin/ui/validators.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AdminRepository _adminRepository;

  LoginBloc({@required AdminRepository adminRepository})
      : assert(adminRepository != null),
        _adminRepository = adminRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events,
    Stream<LoginState> Function(LoginEvent event) next,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged || event is! PasswordChanged);
    });

    final debounceStream = events.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChanged(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChanged(event.password);
    } else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentials(
          email: event.email, password: event.password);
    }
  }

  Stream<LoginState> _mapEmailChanged(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChanged(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentials({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();

    try {
      await _adminRepository.signInWithEmail(email, password);
      yield LoginState.success();
    } catch (e) {
      LoginState.failure();
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }
}
