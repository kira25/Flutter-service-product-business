import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/format_date.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/pages/Main/components/orders_products_pending_details.dart';

class OrdersProductsPending extends StatelessWidget {
  final List<OrderProductResponse> listOrderProduct;
  final Function hp;

  const OrdersProductsPending({this.listOrderProduct, this.hp});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            final ordersPending = listOrderProduct[index];
            return GestureDetector(
              onTap: () => CustomRouteTransition(
                  context: context,
                  child: OrdersProductsPendingDetail(
                    ordersProductsPending: ordersPending,
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
                                      'ID ${ordersPending.id.toUpperCase().substring(0, 8)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: hp(2)),
                                    ),
                                    Text(
                                        '${getOrderTime(ordersPending.createdAt)}')
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(color: kdarkcolor),
                                    children: [
                                      TextSpan(text: 'Products solicitados: '),
                                      TextSpan(
                                          text:
                                              ' ${ordersPending.amountProducts}',
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
                                          text: ' ${ordersPending.clientName}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ]),
                              ),
                              Text('S/.${ordersPending.totalPrice}')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: hp(1),
                thickness: 0,
                color: Colors.transparent,
              ),
          itemCount: listOrderProduct.length),
    );
  }
}
