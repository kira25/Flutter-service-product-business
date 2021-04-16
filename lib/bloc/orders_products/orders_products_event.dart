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

//PENDING PRODUCTS
class OnProductPendingData extends OrdersProductsEvent {
  final List<OrderProductResponse> ordersProducts;

  OnProductPendingData(this.ordersProducts);
}

class OnProductPendingHistory extends OrdersProductsEvent {}

class OnChangeAcceptedPendingProduct extends OrdersProductsEvent{
  final List<OrderProductResponse> ordersProducts;

  OnChangeAcceptedPendingProduct(this.ordersProducts);

}

class OnProductPendingChangeOrderState extends OrdersProductsEvent{
final resp;

  OnProductPendingChangeOrderState({this.resp});

}

//FOLLOWING PRODUCTS

class OnProductFollowingData extends OrdersProductsEvent {
  final dynamic data;

  OnProductFollowingData(this.data);
}

//COMPLETED PRODUCTS

class OnProductCompletedData extends OrdersProductsEvent {
  final dynamic data;

  OnProductCompletedData(this.data);
}

//REJECT PRODUCTS

class OnProductRejectedData extends OrdersProductsEvent {
  final dynamic data;

  OnProductRejectedData(this.data);
}

//LOAD ORDE RPRODUCTS

class OnLoadOrderProduct extends OrdersProductsEvent {
  final List<OrderProductResponse> ordersProducts;

  OnLoadOrderProduct(this.ordersProducts);
}

class OnCleanOrderProductState extends OrdersProductsEvent{}

class OnChangeDeliveryType extends OrdersProductsEvent{
  final DeliveryType deliveryType;

  OnChangeDeliveryType(this.deliveryType);
}