import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_services_event.dart';
part 'orders_services_state.dart';

class OrdersServicesBloc extends Bloc<OrdersServicesEvent, OrdersServicesState> {
  OrdersServicesBloc() : super(OrdersServicesInitial());

  @override
  Stream<OrdersServicesState> mapEventToState(
    OrdersServicesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
