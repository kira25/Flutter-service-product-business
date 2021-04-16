import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';
import 'package:service_products_business/services/auth/auth_service.dart';
import 'package:service_products_business/services/socket/socket_service.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState());

  PreferencesRepository _preferencesRepository = PreferencesRepository();
  AuthService _authService = AuthService();

  SocketService _socketService = SocketService();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthenticationStatus) {
      yield await _mapAuthenticationStatus(event, state);
    } else if (event is AuthenticationLogout) {
      yield await _mapAuthenticationLogout(event, state);
    }
  }

  Future<AuthState> _mapAuthenticationStatus(
      AuthenticationStatus event, AuthState state) async {
    final data = await _preferencesRepository.getData('token');
    try {
      final resp = await _authService.renew(data);

      if (resp[0] == true && resp[1] == false) {
        _socketService.connect();
        return state.copyWith(authenticated: true, isShopInfo: false);
      } else if (resp[0] == true && resp[1] == true) {
        _socketService.connect();

        return state.copyWith(authenticated: true, isShopInfo: true);
      } else {

        await _preferencesRepository.clear();
        return state.copyWith(authenticated: false);
      }
    } catch (e) {
      await _preferencesRepository.clear();
      return state.copyWith(authenticated: false);
    }
  }

  Future<AuthState> _mapAuthenticationLogout(
      AuthenticationLogout event, AuthState state) async {
    _socketService.disconnect();
    await _preferencesRepository.clear();
    return state.copyWith(authenticated: false);
  }
}
