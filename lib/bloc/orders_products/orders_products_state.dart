part of 'orders_products_bloc.dart';

enum IsOrderProduct { UNDEFINED, SUCCESS, FAIL, OFFLINE }

class OrdersProductsState {
  final OrderProductTabs orderProductTabs;
  final IsOrderProduct isOrderProduct;
  final List<OrderProductResponse> listOrderProducts;
  final DeliveryType deliveryType;

  const OrdersProductsState(
      {this.isOrderProduct = IsOrderProduct.UNDEFINED,
      this.listOrderProducts = const [],
      this.orderProductTabs = OrderProductTabs.PENDING,
      this.deliveryType = DeliveryType.MOTORCYCLE});

  OrdersProductsState copyWith(
      {IsOrderProduct isOrderProduct,
      OrderProductTabs orderProductTabs,
      List<OrderProductResponse> listOrderProducts,
      DeliveryType deliveryType}) {
    return OrdersProductsState(
        deliveryType: deliveryType ?? this.deliveryType,
        isOrderProduct: isOrderProduct ?? this.isOrderProduct,
        orderProductTabs: orderProductTabs ?? this.orderProductTabs,
        listOrderProducts: listOrderProducts ?? this.listOrderProducts);
  }
}
