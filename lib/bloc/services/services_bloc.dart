import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_products_business/helpers/enums.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesState());

  @override
  Stream<ServicesState> mapEventToState(
    ServicesEvent event,
  ) async* {
  }
}
