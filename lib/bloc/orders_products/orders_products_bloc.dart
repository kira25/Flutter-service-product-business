import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_products_business/bloc/orders_services/orders_services_bloc.dart';

part 'orders_products_event.dart';
part 'orders_products_state.dart';

class OrdersProductsBloc
    extends Bloc<OrdersProductsEvent, OrdersProductsState> {
  OrdersProductsBloc() : super(OrdersProductsState());

  @override
  Stream<OrdersProductsState> mapEventToState(
    OrdersProductsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is OnProductPending) {
      yield state.copyWith(
          showPending: true,
          showCompleted: false,
          showFollowing: false,
          showRejected: false);
    } else if (event is OnProductFollowing) {
      yield state.copyWith(
          showFollowing: true,
          showCompleted: false,
          showPending: false,
          showRejected: false);
    } else if (event is OnProductCompleted) {
      yield state.copyWith(
          showCompleted: true,
          showFollowing: false,
          showPending: false,
          showRejected: false);
    } else if (event is OnProductRejected) {
      yield state.copyWith(
          showRejected: true,
          showCompleted: false,
          showFollowing: false,
          showPending: false);
    }
  }
}
