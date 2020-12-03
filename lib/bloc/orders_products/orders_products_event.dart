part of 'orders_products_bloc.dart';

abstract class OrdersProductsEvent extends Equatable {
  const OrdersProductsEvent();

  @override
  List<Object> get props => [];
}

class OnProductPending extends OrdersProductsEvent {}

class OnProductFollowing extends OrdersProductsEvent {}

class OnProductCompleted extends OrdersProductsEvent {}

class OnProductRejected extends OrdersProductsEvent {}
