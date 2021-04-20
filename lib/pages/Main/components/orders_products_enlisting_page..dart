import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:service_products_business/bloc/orders_products/orders_products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/models/product_response.dart';
import 'package:service_products_business/pages/Main/main_page.dart';

class ListItem {
  DeliveryType value;
  String name;

  ListItem(this.value, this.name);
}

// ignore: must_be_immutable
class OrderProductsEnlistingPage extends StatelessWidget {
  final OrderProductResponse ordersProductsFollowing;
  final Function hp;
  final int indexOrder;

  OrderProductsEnlistingPage(
      {this.ordersProductsFollowing, this.hp, this.indexOrder});


  List<ListItem> listDelivery = [
    ListItem(DeliveryType.MOTORCYCLE, 'Motorizado'),
    ListItem(DeliveryType.CAR, 'Carro')
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<OrdersProductsBloc, OrdersProductsState>(
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
            elevation: 5,
            backgroundColor: kprimarycolorlight,
            leading: IconButton(
              icon: Icon(Icons.close),
              color: kdarkcolor,
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'ID ${ordersProductsFollowing.id.toUpperCase().substring(0, 8)}',
              style: TextStyle(color: kdarkcolor, fontWeight: FontWeight.bold),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(18),
                width: size.width * 0.35,
                alignment: Alignment.center,
                child: Text(
                  'Alistando el pedido'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: hp(1.3), color: kprimarycolorlight),
                ),
                color: kEnlistingDelivery,
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                height: size.height * 0.9,
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
                              padding: EdgeInsets.symmetric(horizontal: hp(3)),
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
                                  Text('${ordersProductsFollowing.clientName}')
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: hp(3)),
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
                                      '${ordersProductsFollowing.clientCellphone}')
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: hp(3)),
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
                                      '${ordersProductsFollowing.clientAddress}')
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
                      'Productos',
                      style: TextStyle(
                          color: kdarkcolor,
                          fontSize: hp(2.3),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: hp(2),
                    ),
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final orderedProducts =
                                ordersProductsFollowing.selectedProducts[index];
                            return FutureBuilder<Product>(
                                future: getOrderedProductById(
                                    ordersProductsFollowing
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
                                                      color:
                                                          Colors.blueGrey[100],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
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
                                              padding: EdgeInsets.only(top: 10),
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
                                                  Text(
                                                    'Listo para entrega',
                                                    style: TextStyle(
                                                        color: kstockAvailable,
                                                        fontSize: hp(2)),
                                                  )
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
                              ordersProductsFollowing.selectedProducts.length),
                    ),
                    SizedBox(
                      height: hp(3),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Repatidor',
                            style: TextStyle(
                                color: kdarkcolor,
                                fontSize: hp(2.3),
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: hp(2),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: kintroNotSelected.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 25, right: 20),
                              child: DropdownButton(
                                underline: SizedBox(),
                                isExpanded: true,
                                value: state.deliveryType,
                                onChanged: (value) =>
                                    BlocProvider.of<OrdersProductsBloc>(context)
                                        .mapOnDeliveryType(value),
                                items: listDelivery.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.name),
                                    value: e.value,
                                  );
                                }).toList(),
                              )),
                          SizedBox(
                            height: hp(5),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: hp(16),
                            child: Card(
                              elevation: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: hp(3)),
                                    margin: EdgeInsets.only(bottom: hp(1)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          style: TextStyle(
                                              color: kintroNotSelected,
                                              fontSize: hp(2)),
                                        ),
                                        Text(
                                          'S/ ${ordersProductsFollowing.totalPrice}.00',
                                          style: TextStyle(
                                              color: kdarkcolor,
                                              fontSize: hp(3),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  MaterialButton(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onPressed: () => customShowDialog(context,
                                        title:
                                            '¿Estas seguro de aceptar este \npedido?',
                                        titleOption1: 'Cancelar',
                                        actionOption1: () =>
                                            Navigator.pop(context),
                                        color2: kintroselected,
                                        titleOption2: 'Si, aceptar',
                                        actionOption2: () => BlocProvider.of<
                                                OrdersProductsBloc>(context)
                                            .mapOnProductPendingChangeOrderState(
                                                ordersProductsFollowing
                                                    .selectedProducts,
                                                OrderProductStage
                                                    .ASSIGNING_DELIVERY_MAN,
                                                ordersProductsFollowing.id,
                                                deliveryType:
                                                    state.deliveryType.index)),
                                    child: Container(
                                        height: 45,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                            'Pedido listo para entregar',
                                            style: TextStyle(
                                                color: kprimarycolorlight,
                                                fontSize: hp(2.5),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
