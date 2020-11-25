part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final FormzStatus status;

  final Email email;

  final Password password;

  final bool failLogging;

  final bool isShopInfo;

  LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.failLogging = false,
    this.isShopInfo = false,
  });

  LoginState copyWith(
      {FormzStatus status,
      Email email,
      Password password,
      bool failLogging,
      bool isShopInfo}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        failLogging: failLogging ?? this.failLogging,
        isShopInfo: isShopInfo ?? this.isShopInfo);
  }

  @override
  List<Object> get props => [status, email, password, failLogging, isShopInfo];
}
