import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_products_business/bloc/orders_products/orders_products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';

class FloatingOrderProductButton extends StatelessWidget {
  const FloatingOrderProductButton({
    Key key,
    @required this.hp,
    @required this.ordersProductsPending,
/*
    this.filter,
*/
    this.orderId,
  }) : super(key: key);

  final Function hp;
/*
  final List<SelectedProducts> filter;
*/
  final OrderProductResponse ordersProductsPending;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final List<SelectedProducts> filterSelected = ordersProductsPending.selectedProducts
        .where((element) => element.accepted == true)
        .toList();
    return Container(
      alignment: Alignment.center,
      height: hp(16),
      child: Card(
        elevation: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hp(3)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(color: kintroNotSelected, fontSize: 18),
                  ),
                  Text(
                    'S/ ${ordersProductsPending.totalPrice}.00',
                    style: TextStyle(
                        color: kdarkcolor,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => customShowDialog(context,
                        title: '¿Estas seguro de aceptar este \npedido?',
                        titleOption1: 'Cancelar',
                        actionOption1: () => Navigator.pop(context),
                        color2: kintroselected,
                        titleOption2: 'Si, aceptar',
                        actionOption2: () =>
                            BlocProvider.of<OrdersProductsBloc>(context)
                                .mapOnProductPendingChangeOrderState(
                                filterSelected,
                                OrderProductStage.ENLISTING_ORDER,
                                orderId)),
                    child: Container(
                        height: 45,
                        width: hp(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              primaryColor,
                              secondaryColor,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Aceptar pedido',
                            style: TextStyle(
                                color: kprimarycolorlight, fontSize: 16),
                          ),
                        )),
                  ),
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: null,
                    child: Container(
                        height: 45,
                        width: hp(18),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: kintroNotSelected.shade200),
                        child: Center(
                          child: Text(
                            'Rechazar',
                            style: TextStyle(color: kdarkcolor, fontSize: 16),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
