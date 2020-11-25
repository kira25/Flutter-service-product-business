import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:service_products_business/models/forgotpassword/forgot_models.dart';
import 'package:service_products_business/services/auth/auth_service.dart';

part 'forgotpassword_event.dart';
part 'forgotpassword_state.dart';

class ForgotpasswordBloc
    extends Bloc<ForgotpasswordEvent, ForgotpasswordState> {
  ForgotpasswordBloc() : super(ForgotpasswordState());

  AuthService _authService = AuthService();

  @override
  Stream<ForgotpasswordState> mapEventToState(
    ForgotpasswordEvent event,
  ) async* {
    if (event is SendEmail) {
      yield await _mapSendEmail(event, state);
    } else if (event is VerifyPasswordPin) {
      yield await _mapVerifyPasswordPin(event, state);
    } else if (event is ResetPassword) {
      yield await _mapResetPassword(event, state);
    } else if (event is PinChanged) {
      yield _mapPinChanged(event, state);
    } else if (event is EmailChanged) {
      yield _mapEmailChanged(event, state);
    } else if (event is PasswordChanged) {
      yield _mapPasswordChanged(event, state);
    } else if (event is ConfirmPasswordChanged) {
      yield _mapConfirmPasswordChanged(event, state);
    }
  }

  ForgotpasswordState _mapEmailChanged(
      EmailChanged event, ForgotpasswordState state) {
    final email = ForgotEmail.dirty(event.email);
    print(email);
    return state.copyWith(email: email, status: Formz.validate([email]));
  }

  ForgotpasswordState _mapPasswordChanged(
      PasswordChanged event, ForgotpasswordState state) {
    final password = ForgotPassword.dirty(event.password);
    return state.copyWith(
        password: password, statusResetPassword: Formz.validate([password]));
  }

  ForgotpasswordState _mapConfirmPasswordChanged(
      ConfirmPasswordChanged event, ForgotpasswordState state) {
    final confirmpassword = ForgotConfirmPassword.dirty(event.confirmpassword);

    return state.copyWith(
        confirmPassword: confirmpassword,
        statusResetPassword: Formz.validate([confirmpassword]));
  }

  Future<ForgotpasswordState> _mapSendEmail(
      SendEmail event, ForgotpasswordState state) async {
    print('SendEmail');
    try {
      print('email : ${state.email.value}');
      final sendemail = await _authService.sendEmail(state.email.value);
      print(sendemail);
      if (sendemail == true) {
        return state.copyWith(
            status: FormzStatus.submissionSuccess,
            resetPasswordEmail: state.email.value);
      } else {
        return state.copyWith(
          status: FormzStatus.submissionFailure,
        );
      }
    } catch (e) {
      print('error: $e');
      return state.copyWith(
        failSendEmail: true,
      );
    }
  }

//VERIFY PASSWORD PIN
  Future<ForgotpasswordState> _mapVerifyPasswordPin(
      VerifyPasswordPin event, ForgotpasswordState state) async {
    print('VerifyPasswordPin');

    try {
      print('state pin : ${state.pin}');
      print('state reset : ${state.resetPasswordEmail}');
      final passwordtoken = await _authService.verifyPasswordToken(
          state.resetPasswordEmail, state.pin);

      if (passwordtoken != null) {
        return state.copyWith(
            passwordtoken: passwordtoken,
            failPin: FailPinType.success);
      } else {
        return state.copyWith(
            failPin: FailPinType.fail);
      }
    } catch (e) {
      print(e);
      return state.copyWith(
        failPin: FailPinType.error
      );
    }
  }

  Future<ForgotpasswordState> _mapResetPassword(
      ResetPassword event, ForgotpasswordState state) async {
    print('ResetPassword');

    print('validated');
    print('${state.resetPasswordEmail}');
    print('${state.password.value}');
    print('${state.passwordtoken}');
    try {
      final sendemail = await _authService.resetPassword(
          state.resetPasswordEmail, state.password.value, state.passwordtoken);
      print(sendemail);
      if (sendemail) {
        return state.copyWith(
            statusResetPassword: FormzStatus.submissionSuccess);
      } else {
        return state.copyWith(
            statusResetPassword: FormzStatus.submissionFailure);
      }
    } catch (e) {
      print(e);
      return state.copyWith(
        statusResetPassword: FormzStatus.invalid,
      );
    }
  }

  ForgotpasswordState _mapPinChanged(
      PinChanged event, ForgotpasswordState state) {
    print('PinChanged');
    print(event.pin);
    return state.copyWith(
      pin: event.pin,
    );
  }
}
