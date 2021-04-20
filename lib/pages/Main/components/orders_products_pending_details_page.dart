import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:service_products_business/bloc/orders_products/orders_products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/order_product_pending_id.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/models/product_response.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/services/product/product_service.dart';
import 'package:service_products_business/widgets/floating_order_product_button.dart';

class OrdersProductsPendingDetailPage extends StatelessWidget {
  final OrderProductResponse ordersProductsPending;
  final Function hp;
  final int indexOrder;

  OrdersProductsPendingDetailPage(
      {this.ordersProductsPending, this.hp, this.indexOrder});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersProductsBloc, OrdersProductsState>(
        listenWhen: (previous, current) =>
            previous.isOrderProduct != current.isOrderProduct,
        listener: (_, state) {
          if (state.isOrderProduct == IsOrderProduct.SUCCESS) {
            CustomRouteTransition(
                context: context,
                child: MainPage(),
                animation: AnimationType.fadeIn);
          } else if (state.isOrderProduct == IsOrderProduct.FAIL) {
            showDialog(
                context: _,
                builder: (_) => new AlertDialog(
                      title: new Text("No se encontro el producto"),
                    ));
          } else if (state.isOrderProduct == IsOrderProduct.OFFLINE) {
            showDialog(
                context: _,
                builder: (_) => new AlertDialog(
                      title: new Text("Falla en la conexion"),
                    ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kprimarycolorlight,
              title: Text(
                'ID ${ordersProductsPending.id.toUpperCase().substring(0, 8)}',
                style:
                    TextStyle(color: kdarkcolor, fontWeight: FontWeight.bold),
              ),
              elevation: 5,
              leading: IconButton(
                icon: Icon(Icons.close),
                color: kdarkcolor,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(hp(2.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informacion del cliente',
                        style: TextStyle(
                            color: kdarkcolor,
                            fontSize: hp(2.3),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: hp(23),
                        child: Card(
                          margin: EdgeInsets.only(top: hp(3), bottom: hp(3)),
                          elevation: 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: hp(3)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //TODO: GET IMAGE PROFILE USER
                                    CircleAvatar(
                                      backgroundImage: Image.network(
                                              'https://th.bing.com/th/id/R891fc024b263bed19c9ab5f097b1c8e0?rik=HBc8HFFGhwcfGg&riu=http%3a%2f%2fbestprofilepix.com%2fwp-content%2fuploads%2f2014%2f03%2fcute-and-beautifull-girls-profile-pictures.jpg&ehk=lZ1qf%2f63t%2bj8M4o7U0ferDRp4NvQHa1mHm1rZYF97Hc%3d&risl=&pid=ImgRaw')
                                          .image,
                                      radius: hp(1.5),
                                    ),
                                    SizedBox(
                                      width: hp(2),
                                    ),
                                    Text('${ordersProductsPending.clientName}')
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: hp(3)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.call,
                                      color: kintroselected,
                                    ),
                                    SizedBox(
                                      width: hp(2),
                                    ),
                                    Text(
                                        '${ordersProductsPending.clientCellphone}')
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: hp(3)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.mapMarker,
                                      color: Colors.red[400],
                                    ),
                                    SizedBox(
                                      width: hp(2),
                                    ),
                                    Text(
                                        '${ordersProductsPending.clientAddress}')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: hp(2),
                      ),
                      //PRODUCTOS SOLICITADOS
                      Text(
                        'Productos solicitados',
                        style: TextStyle(
                            color: kdarkcolor,
                            fontSize: hp(2.3),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: hp(2),
                      ),
                      Container(
                        height: hp(16),
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final orderedProducts =
                                  ordersProductsPending.selectedProducts[index];
                              return FutureBuilder<Product>(
                                  future: getOrderedProductById(
                                      ordersProductsPending
                                          .selectedProducts[index].productId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        height: hp(16),
                                        child: Card(
                                          elevation: 5,
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .blueGrey[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    padding: EdgeInsets.all(5),
                                                    margin: EdgeInsets.all(15),
                                                    child: Text(orderedProducts
                                                                .amount
                                                                .toString()
                                                                .length ==
                                                            1
                                                        ? '0${orderedProducts.amount}'
                                                        : '${orderedProducts.amount}'),
                                                    alignment:
                                                        Alignment.topCenter,
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: 270,
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            '${snapshot.data.name}'),
                                                        snapshot.data.price
                                                                    .offertPrice ==
                                                                null
                                                            ? Text(
                                                                'S/${snapshot.data.price.normalPrice}.00')
                                                            : Text(
                                                                'S/${snapshot.data.price.offertPrice}.00')
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        orderedProducts.color !=
                                                                null
                                                            ? RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                    TextSpan(
                                                                        text:
                                                                            'Color: ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey)),
                                                                    TextSpan(
                                                                        text:
                                                                            '${handleAdminColorStock(handleIntToAdminColorType(orderedProducts.color))}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                kdarkcolor,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                  ]))
                                                            : Container(),
                                                        SizedBox(
                                                          width: hp(3),
                                                        ),
                                                        orderedProducts.size !=
                                                                null
                                                            ? RichText(
                                                                text: TextSpan(
                                                                    children: [
                                                                    TextSpan(
                                                                        text:
                                                                            'Talla: ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey)),
                                                                    TextSpan(
                                                                        text:
                                                                            '${handleAdminProductSize(handleResponseToSize(orderedProducts.size))}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                kdarkcolor,
                                                                            fontWeight:
                                                                                FontWeight.bold)),
                                                                  ]))
                                                            : Container(),
                                                      ],
                                                    ),
                                                    CheckboxListTile(
                                                      activeColor:
                                                          kintroselected,
                                                      onChanged: (value) => BlocProvider
                                                              .of<OrdersProductsBloc>(
                                                                  context)
                                                          .mapOnChangeAcceptedPendingProduct(
                                                              value,
                                                              indexOrder,
                                                              index),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      dense: true,
                                                      value: orderedProducts
                                                          .accepted,
                                                      title: RichText(
                                                          text: TextSpan(
                                                              children: [
                                                            TextSpan(
                                                                text: 'Stock: ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey)),
                                                            TextSpan(
                                                                text:
                                                                    '${OrderProductPendingId.orderProductPendingStock(orderedProducts.color, orderedProducts.size, snapshot.data, orderedProducts.amount)}',
                                                                style: OrderProductPendingId.orderProductPendingStock(
                                                                            orderedProducts
                                                                                .color,
                                                                            orderedProducts
                                                                                .size,
                                                                            snapshot
                                                                                .data,
                                                                            orderedProducts
                                                                                .amount) ==
                                                                        'Sin Stock'
                                                                    ? TextStyle(
                                                                        color:
                                                                            kwrongAnswer)
                                                                    : TextStyle(
                                                                        color:
                                                                            kstockAvailable)),
                                                          ])),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  });
                            },
                            separatorBuilder: (context, index) => Divider(
                                  height: hp(2),
                                  color: Colors.transparent,
                                ),
                            itemCount:
                                ordersProductsPending.selectedProducts.length),
                      ),
                      SizedBox(
                        height: hp(2),
                      ),
                      Container(
                        height: hp(8),
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Icon(
                                  Icons.warning,
                                  color: kyellowcolor,
                                  size: hp(4),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  'Los productos no seleccionados o sin stock se\nreembolsaran automaticamente al cliente',
                                  style: TextStyle(fontSize: hp(1.8)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: hp(3),
                      ),
                      FloatingOrderProductButton(
                          orderId: ordersProductsPending.id,
                          hp: hp,
                          ordersProductsPending: ordersProductsPending),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
