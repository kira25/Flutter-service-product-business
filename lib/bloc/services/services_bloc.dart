import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesInitial());

  @override
  Stream<ServicesState> mapEventToState(
    ServicesEvent event,
  ) async* {
  }
}
