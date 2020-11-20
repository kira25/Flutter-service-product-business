part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}



class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged(this.email);

  @override
  // TODO: implement props
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);

  @override
  // TODO: implement props
  List<Object> get props => [password];
}


class LoginSubmitted extends LoginEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}


