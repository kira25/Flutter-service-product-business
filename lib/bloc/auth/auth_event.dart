part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthenticationStatus extends AuthEvent {}

class AuthenticationLogout extends AuthEvent {}
