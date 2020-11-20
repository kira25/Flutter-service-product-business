part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final FormzStatus status;
  final Firstname firstname;
  final LastName lastname;
  final RegisterPassword registerPassword;
  final RegisterEmail registerEmail;
  final Identifier identifier;
  final Cellphone cellphone;
  final Shopname shopname;
  final bool failRegister;
  final RegisterConfirmPassword registerConfirmPassword;

  RegisterState(
      {this.registerConfirmPassword = const RegisterConfirmPassword.pure(),
      this.status = FormzStatus.pure,
      this.firstname = const Firstname.pure(),
      this.lastname = const LastName.pure(),
      this.registerPassword = const RegisterPassword.pure(),
      this.registerEmail = const RegisterEmail.pure(),
      this.identifier = const Identifier.pure(),
      this.cellphone = const Cellphone.pure(),
      this.shopname = const Shopname.pure(),
      this.failRegister = false});

  RegisterState copyWith(
      {RegisterConfirmPassword registerConfirmPassword,
      FormzStatus status,
      Firstname firstname,
      LastName lastname,
      RegisterPassword registerPassword,
      RegisterEmail registerEmail,
      Identifier identifier,
      Cellphone cellphone,
      Shopname shopname,
      bool failRegister}) {
    return RegisterState(
        registerConfirmPassword:
            registerConfirmPassword ?? this.registerConfirmPassword,
        status: status ?? this.status,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        registerPassword: registerPassword ?? this.registerPassword,
        registerEmail: registerEmail ?? this.registerEmail,
        identifier: identifier ?? this.identifier,
        cellphone: cellphone ?? this.cellphone,
        shopname: shopname ?? this.shopname,
        failRegister: failRegister ?? this.failRegister);
  }

  @override
  List<Object> get props => [
        registerConfirmPassword,
        status,
        firstname,
        lastname,
        registerPassword,
        registerEmail,
        identifier,
        cellphone,
        shopname,
        failRegister
      ];
}
