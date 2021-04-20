import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:service_products_business/bloc/orders_products/orders_products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/pages/Main/components/orders_products_rejected_details_page.dart';

class OrdersProductsRejected extends StatefulWidget {
  final List<OrderProductResponse> listOrderProduct;
  final Function hp;

  OrdersProductsRejected({Key key, this.listOrderProduct, this.hp})
      : super(key: key);

  @override
  _OrdersProductsRejectedState createState() => _OrdersProductsRejectedState();
}

class _OrdersProductsRejectedState extends State<OrdersProductsRejected> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrdersProductsBloc>(context)
        .mapOnProductRejectedInitialListOrderProduct(
            list: widget.listOrderProduct,filter: false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<OrdersProductsBloc, OrdersProductsState>(
        builder: (context, state) {
      return Expanded(
        child: Stack(
          children: [
            Container(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final ordersRejected = state.listRejectedProducts[index];
                      return GestureDetector(
                        onTap: () => CustomRouteTransition(
                            context: context,
                            child: OrdersProductsRejectedPage(
                              hp: widget.hp,
                              ordersProductsRejected: ordersRejected,
                              indexOrder: index,
                            )),
                        child: Container(
                          alignment: Alignment.center,
                          height: widget.hp(23),
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.only(
                                top: widget.hp(2),
                                bottom: widget.hp(3),
                                left: widget.hp(3),
                                right: widget.hp(3)),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: widget.hp(3)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'ID ${ordersRejected.id.toUpperCase().substring(0, 8)}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: widget.hp(2)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: kdarkcolor),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          'Productos por entregar: '),
                                                  TextSpan(
                                                      text:
                                                          ' ${ordersRejected.amountProducts}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ]),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: kdarkcolor),
                                                children: [
                                                  TextSpan(text: 'Cliente: '),
                                                  TextSpan(
                                                      text:
                                                          ' ${ordersRejected.clientName}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ]),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'S/.${ordersRejected.totalPrice}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height: widget.hp(2.5),
                                                width: widget.hp(20),
                                                margin:
                                                    EdgeInsets.only(right: 15),
                                                child: Text(
                                                  'Pedido rechazado'
                                                      .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: widget.hp(1.1),
                                                      color:
                                                          kprimarycolorlight),
                                                ),
                                                color: kwrongAnswer,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: state.listRejectedProducts.length)),
            Positioned(
                right: 20,
                bottom: 25,
                child: CircleAvatar(
                    maxRadius: 20,
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => showModalBottomSheet(
                        elevation: 5,
                        isDismissible: false,
                        context: context,
                        builder: (context) {
                          //FILTER BY DATE
                          return SizedBox(
                            height: size.height * 0.4,
                            child: Scaffold(
                              appBar: AppBar(
                                centerTitle: true,
                                elevation: 5,
                                backgroundColor: kprimarycolorlight,
                                leading: IconButton(
                                    color: kdarkcolor,
                                    icon: Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context)),
                                title: Text(
                                  'Pedidos rechazados',
                                  style: TextStyle(
                                      color: kdarkcolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              body: Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: DatePickerWidget(
                                        onChange: (dateTime, selectedIndex) =>
                                            BlocProvider.of<OrdersProductsBloc>(
                                                    context)
                                                .mapOnProductRejectedDateFilter(
                                                    dateTime),
                                        looping: false,
                                        pickerTheme: DateTimePickerTheme(
                                          dividerColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        firstDate: DateTime(2021),
                                        dateFormat: "MMMM-yyyy",
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () => BlocProvider.of<OrdersProductsBloc>(context).mapOnProductRejectedInitialListOrderProduct(filter: true),
                                        child: Container(
                                          height: 20,
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          child: Text(
                                            'Aplicar',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )))
          ],
        ),
      );
    });
  }
}
