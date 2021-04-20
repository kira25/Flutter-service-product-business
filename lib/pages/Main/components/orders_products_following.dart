import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/pages/Main/components/orders_products_assigning_page.dart';
import 'package:service_products_business/pages/Main/components/orders_products_deliverypoint_page.dart';
import 'package:service_products_business/pages/Main/components/orders_products_enlisting_page..dart';
import 'package:service_products_business/pages/Main/components/orders_products_onwaystore_páge.dart';

class OrdersProductsFollowing extends StatelessWidget {
  final List<OrderProductResponse> listOrderProduct;
  final Function hp;

  const OrdersProductsFollowing({this.listOrderProduct, this.hp});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            final ordersFollowing = listOrderProduct[index];

            return GestureDetector(
              onTap: () =>
              ordersFollowing.orderState == 4 ? CustomRouteTransition(
                  context: context,
                  child: OrderProductsDeliveryPointPage(
                    ordersProductsFollowing: ordersFollowing,
                    indexOrder: index,
                    hp: hp,
                  )):
              ordersFollowing.orderState == 3 ? CustomRouteTransition(
                  context: context,
                  child: OrdersProductsOnWayStorePage(
                    ordersProductsFollowing: ordersFollowing,
                    indexOrder: index,
                    hp: hp,
                  )) :
              ordersFollowing.orderState == 2
                  ? CustomRouteTransition(
                  context: context,
                  child: OrdersProductsAssigningPage(
                    ordersProductsFollowing: ordersFollowing,
                    indexOrder: index,
                    hp: hp,
                  ))
                  : CustomRouteTransition(
                  context: context,
                  child: OrderProductsEnlistingPage(
                    ordersProductsFollowing: ordersFollowing,
                    indexOrder: index,
                    hp: hp,
                  )),
              child: Container(
                alignment: Alignment.center,
                height: hp(23),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.only(
                      top: hp(2), bottom: hp(3), left: hp(3), right: hp(3)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: CircleAvatar(
                            child: Icon(FontAwesomeIcons.cube),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: hp(3)),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ID ${ordersFollowing.id.toUpperCase()
                                          .substring(0, 8)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: hp(2)),
                                    ),
                                    ordersFollowing.orderState ==
                                        OrderProductStage.ON_WAY_DELIVERY_POINT
                                            .index ?
                                    Icon(
                                      FontAwesomeIcons.car,
                                      size: 15,
                                    )
                                        :
                                    ordersFollowing.orderState ==
                                        OrderProductStage
                                            .ASSIGNING_DELIVERY_MAN
                                            .index ||
                                        ordersFollowing.orderState ==
                                            OrderProductStage
                                                .ON_WAY_STORE.index
                                        ? Icon(
                                      FontAwesomeIcons.motorcycle,
                                      size: 15,
                                    )
                                        : Container()
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: kdarkcolor),
                                    children: [
                                      TextSpan(text: 'Productos por entregar: '),
                                      TextSpan(
                                          text:
                                          ' ${ordersFollowing.amountProducts}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: kdarkcolor),
                                    children: [
                                      TextSpan(text: 'Cliente: '),
                                      TextSpan(
                                          text:
                                          ' ${ordersFollowing.clientName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'S/.${ordersFollowing.totalPrice}',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: hp(2.5),
                                    width: hp(20),
                                    margin: EdgeInsets.only(right: 15),
                                    child: Text(
                                      ordersFollowing.orderState ==
                                          OrderProductStage
                                              .ENLISTING_ORDER.index
                                          ? 'Alistando el pedido'.toUpperCase()
                                          : ordersFollowing.orderState ==
                                          OrderProductStage
                                              .ASSIGNING_DELIVERY_MAN
                                              .index
                                          ? 'Asignando repartidor'
                                          .toUpperCase()
                                          : ordersFollowing.orderState ==
                                          OrderProductStage
                                              .ON_WAY_STORE.index
                                          ? 'En camino a la tienda'
                                          .toUpperCase()
                                          : ordersFollowing
                                          .orderState ==
                                          OrderProductStage
                                              .ON_WAY_DELIVERY_POINT
                                              .index
                                          ? 'En camino al pto de entrega'
                                          .toUpperCase()
                                          : '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: hp(1.1),
                                          color: kprimarycolorlight),
                                    ),
                                    color: ordersFollowing.orderState ==
                                        OrderProductStage
                                            .ENLISTING_ORDER.index
                                        ? kEnlistingDelivery
                                        : kintroselected,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) =>
              Divider(
                height: hp(1),
                thickness: 0,
                color: Colors.transparent,
              ),
          itemCount: listOrderProduct.length),
    );
  }
}
