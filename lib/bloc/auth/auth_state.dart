part of 'auth_bloc.dart';

@immutable
class AuthState {
  final bool authenticated;

  AuthState({this.authenticated = false});

  AuthState copyWith({authenticated}) {
    return AuthState(authenticated: authenticated ?? this.authenticated);
  }
}
