import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_services_event.dart';
part 'orders_services_state.dart';

class OrdersServicesBloc
    extends Bloc<OrdersServicesEvent, OrdersServicesState> {
  OrdersServicesBloc() : super(OrdersServicesState());

  @override
  Stream<OrdersServicesState> mapEventToState(
    OrdersServicesEvent event,
  ) async* {
    if (event is OnServicePending) {
      yield state.copyWith(
          showPending: true, showCancel: false, showDone: false);
    } else if (event is OnServiceDone) {
      yield state.copyWith(
          showDone: true, showCancel: false, showPending: false);
    } else if (event is OnServiceCancel) {
      yield state.copyWith(
          showCancel: true, showDone: false, showPending: false);
          print(state.showCancel);
    }
  }
}
