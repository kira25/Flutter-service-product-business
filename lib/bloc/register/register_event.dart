part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class FirstNameChanged extends RegisterEvent {
  final String firstname;

  FirstNameChanged(this.firstname);

  @override
  // TODO: implement props
  List<Object> get props => [firstname];
}

class LastNameChanged extends RegisterEvent {
  final String lastname;

  LastNameChanged(this.lastname);

  @override
  // TODO: implement props
  List<Object> get props => [lastname];
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  // TODO: implement props
  List<Object> get props => [password];
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged(this.email);

  @override
  // TODO: implement props
  List<Object> get props => [email];
}

class IdentifierChanged extends RegisterEvent {
  final String identifier;

  IdentifierChanged(this.identifier);

  @override
  // TODO: implement props
  List<Object> get props => [identifier];
}

class CellphoneChanged extends RegisterEvent {
  final String cellphone;

  CellphoneChanged(this.cellphone);

  @override
  // TODO: implement props
  List<Object> get props => [cellphone];
}

class ShopNameChanged extends RegisterEvent {
  final String shopname;

  ShopNameChanged(this.shopname);

  @override
  // TODO: implement props
  List<Object> get props => [shopname];
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String confirmpassword;

  ConfirmPasswordChanged(this.confirmpassword);

  @override
  // TODO: implement props
  List<Object> get props => [confirmpassword];
}

class RegisterSubmitted extends RegisterEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
