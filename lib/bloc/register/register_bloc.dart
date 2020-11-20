import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:service_products_business/models/register/register_models.dart';
import 'package:service_products_business/services/auth/auth_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState());

  AuthService _authService = AuthService();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is FirstNameChanged) {
      yield _mapFirstNameChanged(event, state);
    } else if (event is LastNameChanged) {
      yield _mapLastNameChanged(event, state);
    } else if (event is PasswordChanged) {
      yield _mapPasswordChanged(event, state);
    } else if (event is EmailChanged) {
      yield _mapEmailChanged(event, state);
    } else if (event is IdentifierChanged) {
      yield _mapIdentifierChanged(event, state);
    } else if (event is CellphoneChanged) {
      yield _mapCellphoneChanged(event, state);
    } else if (event is ShopNameChanged) {
      yield _mapShopNameChanged(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmitted(event,state);
    } else if (event is ConfirmPasswordChanged) {
      yield _mapConfirmPasswordChanged(event, state);
    }
  }

  RegisterState _mapFirstNameChanged(
      FirstNameChanged event, RegisterState state) {
    final firstname = Firstname.dirty(event.firstname);
    
    return state.copyWith(
        firstname: firstname,
        status: Formz.validate([
          firstname
        ]));
  }

  RegisterState _mapLastNameChanged(
      LastNameChanged event, RegisterState state) {
    print(state.status);
    final lastname = LastName.dirty(event.lastname);
    return state.copyWith(
        lastname: lastname, status: Formz.validate([lastname]));
  }

  RegisterState _mapPasswordChanged(
      PasswordChanged event, RegisterState state) {
    final password = RegisterPassword.dirty(event.password);
    return state.copyWith(
        registerPassword: password, status: Formz.validate([password]));
  }

  RegisterState _mapEmailChanged(EmailChanged event, RegisterState state) {
    final email = RegisterEmail.dirty(event.email);
    return state.copyWith(
        registerEmail: email, status: Formz.validate([email]));
  }

  RegisterState _mapIdentifierChanged(
      IdentifierChanged event, RegisterState state) {
    final identifier = Identifier.dirty(event.identifier);
    print(state.status);
    return state.copyWith(
        identifier: identifier, status: Formz.validate([identifier]));
  }

  RegisterState _mapCellphoneChanged(
      CellphoneChanged event, RegisterState state) {
    final cellphone = Cellphone.dirty(event.cellphone);
    return state.copyWith(
        cellphone: cellphone, status: Formz.validate([cellphone]));
  }

  RegisterState _mapShopNameChanged(
      ShopNameChanged event, RegisterState state) {
    final shopname = Shopname.dirty(event.shopname);
    return state.copyWith(
        shopname: shopname, status: Formz.validate([shopname]));
  }

  RegisterState _mapConfirmPasswordChanged(
      ConfirmPasswordChanged event, RegisterState state) {
    final confirmpassword =
        RegisterConfirmPassword.dirty(event.confirmpassword);
    print(confirmpassword);
    print(state.status);
    return state.copyWith(
        registerConfirmPassword: confirmpassword,
        status: Formz.validate([confirmpassword]));
  }

//REGISTER
  Stream<RegisterState> _mapRegisterSubmitted(
      RegisterSubmitted event, RegisterState state) async* {
    print('RegisterSubmitted');
    print(state.status);
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      print('validated');
      try {
        final register = await _authService.register(
            state.firstname.value,
            state.lastname.value,
            state.identifier.value,
            state.registerEmail.value,
            state.cellphone.value,
            state.shopname.value,
            state.registerPassword.value);
        if (register) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } else {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      } catch (e) {
        print(e);
        yield state.copyWith(
          failRegister: true,
        );
        Future.delayed(Duration(milliseconds: 1000));
        yield state.copyWith(
          failRegister: false,
        );
      }
    }
  }
}
