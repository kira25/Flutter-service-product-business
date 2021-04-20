part of 'orders_products_bloc.dart';

enum IsOrderProduct { UNDEFINED, SUCCESS, FAIL, OFFLINE }

class OrdersProductsState {
  final OrderProductTabs orderProductTabs;
  final IsOrderProduct isOrderProduct;
  final List<OrderProductResponse> listOrderProducts;
  final DeliveryType deliveryType;
  final DateTime dateRejected;
  final DateTime dateCompleted;
  final List<OrderProductResponse> listCompletedProducts;
  final List<OrderProductResponse> listRejectedProducts;

  const OrdersProductsState(
      {this.listCompletedProducts = const [],
      this.listRejectedProducts = const [],
      this.dateRejected,
      this.dateCompleted,
      this.isOrderProduct = IsOrderProduct.UNDEFINED,
      this.listOrderProducts = const [],
      this.orderProductTabs = OrderProductTabs.PENDING,
      this.deliveryType = DeliveryType.MOTORCYCLE});

  OrdersProductsState copyWith(
      {List<OrderProductResponse> listRejectedProducts,
      List<OrderProductResponse> listCompletedProducts,
      DateTime dateCompleted,
      DateTime dateRejected,
      IsOrderProduct isOrderProduct,
      OrderProductTabs orderProductTabs,
      List<OrderProductResponse> listOrderProducts,
      DeliveryType deliveryType}) {
    return OrdersProductsState(
        listCompletedProducts:
            listCompletedProducts ?? this.listCompletedProducts,
        listRejectedProducts: listRejectedProducts ?? this.listRejectedProducts,
        dateCompleted: dateCompleted ?? this.dateCompleted,
        dateRejected: dateRejected ?? this.dateRejected,
        deliveryType: deliveryType ?? this.deliveryType,
        isOrderProduct: isOrderProduct ?? this.isOrderProduct,
        orderProductTabs: orderProductTabs ?? this.orderProductTabs,
        listOrderProducts: listOrderProducts ?? this.listOrderProducts);
  }
}
