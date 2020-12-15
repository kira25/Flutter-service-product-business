import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:service_products_business/models/login/login_models.dart';
import 'package:service_products_business/services/auth/auth_service.dart';
import 'package:service_products_business/services/socket/socket_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState());

  AuthService _authService = AuthService();
  SocketService _socketService = SocketService();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield _mapEmailChanged(event, state);
      print(state.status);
    } else if (event is PasswordChanged) {
      yield _mapPasswordChanged(event, state);
      print(state.status);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmitted(event, state);
    }
  }

  LoginState _mapEmailChanged(EmailChanged event, LoginState state) {
    final email = Email.dirty(event.email);
    return state.copyWith(email: email, status: Formz.validate([email]));
  }

  LoginState _mapPasswordChanged(PasswordChanged event, LoginState state) {
    final password = Password.dirty(event.password);
    return state.copyWith(
        password: password, status: Formz.validate([password]));
  }

  //LOGIN
  Stream<LoginState> _mapLoginSubmitted(
      LoginSubmitted event, LoginState state) async* {
    print('LoginSubmitted');

    if (state.status.isValid) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      print('validated');
      try {
        final login =
            await _authService.logIn(state.email.value, state.password.value);
        print(login);
        if (login[0] == true && login[1] == true) {
          yield state.copyWith(
              status: FormzStatus.submissionSuccess, isShopInfo: true);
          _socketService.connect();
        } else if (login[0] == true && login[1] == false) {
          yield state.copyWith(
              status: FormzStatus.submissionSuccess, isShopInfo: false);
          _socketService.connect();
        } else {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      } catch (e) {
        print(e);
        yield state.copyWith(
          failLogging: true,
        );

        yield state.copyWith(
          failLogging: false,
        );
      }
    }
  }
}
