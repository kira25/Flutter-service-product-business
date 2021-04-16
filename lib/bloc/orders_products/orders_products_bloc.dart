import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/services/orderProducts/order_product_service.dart';
import 'package:service_products_business/services/socket/socket_service.dart';

part 'orders_products_event.dart';

part 'orders_products_state.dart';

class OrdersProductsBloc
    extends Bloc<OrdersProductsEvent, OrdersProductsState> {
  OrdersProductsBloc() : super(OrdersProductsState());

  OrderProductService _orderProductService = OrderProductService();
  SocketService _socketService = SocketService();
  List<OrderProductResponse> listproducts = [];

  @override
  Stream<OrdersProductsState> mapEventToState(
    OrdersProductsEvent event,
  ) async* {
    if (event is OnProductPending) {
      yield state.copyWith(orderProductTabs: OrderProductTabs.PENDING);
    } else if (event is OnProductFollowing) {
      yield state.copyWith(orderProductTabs: OrderProductTabs.FOLLOWING);
    } else if (event is OnProductCompleted) {
      yield state.copyWith(orderProductTabs: OrderProductTabs.COMPLETED);
    } else if (event is OnProductRejected) {
      yield state.copyWith(orderProductTabs: OrderProductTabs.REJECTED);
    } else if (event is OnProductPendingData) {
      yield state.copyWith(listOrderProducts: event.ordersProducts);
    } else if (event is OnLoadOrderProduct) {
      yield state.copyWith(listOrderProducts: event.ordersProducts);
    } else if (event is OnChangeAcceptedPendingProduct) {
      yield state.copyWith(listOrderProducts: event.ordersProducts);
    } else if (event is OnProductPendingChangeOrderState) {
      yield state.copyWith(isOrderProduct: event.resp);
    } else if (event is OnCleanOrderProductState) {
      yield state.copyWith(
          isOrderProduct: IsOrderProduct.UNDEFINED,
          orderProductTabs: OrderProductTabs.PENDING);
    }else if( event is OnChangeDeliveryType){
      yield state.copyWith(deliveryType: event.deliveryType);
    }
  }

  mapOnCleanOrderProductSate() {
    add(OnCleanOrderProductState());
  }

  mapOnProductPendingChangeOrderState(
      List list, OrderProductStage stage, String id,{int deliveryType}) async {
    final resp = await _orderProductService.updateOrderProductStage(
        list, stage.index, id, deliveryType: deliveryType);
    if (resp == true)
      add(OnProductPendingChangeOrderState(resp: IsOrderProduct.SUCCESS));
    else if (resp == false)
      add(OnProductPendingChangeOrderState(resp: IsOrderProduct.FAIL));
    else
      add(OnProductPendingChangeOrderState(resp: IsOrderProduct.OFFLINE));
  }

  mapOnChangeAcceptedPendingProduct(bool value, int indexOrder, int index) {
    final List<OrderProductResponse> temp = state.listOrderProducts
        .where((element) => element.orderState == 0)
        .toList();
    listproducts = [...temp];
    listproducts[indexOrder].selectedProducts[index].accepted = value;
    add(OnChangeAcceptedPendingProduct(listproducts));
  }

  mapOnLoadOrderProduct() async {
    print('OnLoadOrderProducts');
    final orderResponse = await _orderProductService.getOrderProductUser();
    if (orderResponse != null) {
      add(OnLoadOrderProduct(orderResponse));
    }
  }

  mapOnProductPendingData() {
    print('OnProductPendingData');
    _socketService.socket.on('order-product', (data) {
      print('order-product listen');
      final orderproduct = OrderProductResponse.fromJson(data);
      listproducts = [...state.listOrderProducts];
      listproducts.add(orderproduct);
      add(OnProductPendingData(listproducts));
    });
  }

  mapOnDeliveryType(DeliveryType deliveryType){
    add(OnChangeDeliveryType(deliveryType));
  }


}
