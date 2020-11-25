part of 'auth_bloc.dart';

@immutable
class AuthState {
  final bool authenticated;
  final bool isShopInfo;
  AuthState({
    this.authenticated = false,
    this.isShopInfo = false,
  });

  AuthState copyWith({bool authenticated, bool isShopInfo}) {
    return AuthState(
        authenticated: authenticated ?? this.authenticated,
        isShopInfo: isShopInfo ?? this.isShopInfo);
  }
}
