import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:service_products_business/repository/preferences/preferences_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState());

  PreferencesRepository _preferencesRepository = PreferencesRepository();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is AuthenticationStatus) {
      yield await _mapAuthenticationStatus(event, state);
    } else if (event is AuthenticationLogout) {
      yield await _mapAuthenticationLogout(event, state);
    }
  }

  Future<AuthState> _mapAuthenticationStatus(
      AuthenticationStatus event, AuthState state) async {
    final data = await _preferencesRepository.getData('token');
    if (data == null) {
      return state.copyWith(authenticated: false);
    } else {
      return state.copyWith(authenticated: true);
    }
  }

  Future<AuthState> _mapAuthenticationLogout(
      AuthenticationLogout event, AuthState state) async {
    await _preferencesRepository.clear();
    return state.copyWith(authenticated: false);
  }
}
