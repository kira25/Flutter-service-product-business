import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:service_products_business/bloc/orders_products/orders_products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/models/product_response.dart';

class OrdersProductsOnWayStorePage extends StatelessWidget {
  final OrderProductResponse ordersProductsFollowing;
  final Function hp;
  final int indexOrder;

  OrdersProductsOnWayStorePage(
      {Key key, this.ordersProductsFollowing, this.hp, this.indexOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersProductsBloc, OrdersProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final size = MediaQuery.of(context).size;

        return Scaffold(
          appBar: AppBar(
            leadingWidth: size.width * 0.1,
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
                  'En camino a la tienda'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: hp(1.3), color: kprimarycolorlight),
                ),
                color: kintroselected,
              )
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
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
                                    Text(
                                        '${ordersProductsFollowing.clientName}')
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
                                        '${ordersProductsFollowing.clientCellphone}')
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
                                        '${ordersProductsFollowing.clientAddress}')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      Text(
                        'Informacion del repartidor',
                        style: TextStyle(
                            color: kdarkcolor,
                            fontSize: hp(2.3),
                            fontWeight: FontWeight.bold),
                      ),

                      //TODO: GET INFO FROM ID DELIVERY
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
                                              'https://images.pexels.com/photos/4604742/pexels-photo-4604742.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260')
                                          .image,
                                      radius: hp(1.5),
                                    ),
                                    SizedBox(
                                      width: hp(2),
                                    ),
                                    Text('Axel Salazar Fernandez')
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: hp(3)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: kintroselected,
                                        ),
                                        SizedBox(
                                          width: hp(2),
                                        ),
                                        Text('987567321'),
                                      ],
                                    ),
                                    Text(
                                      'Llamar',
                                      style: TextStyle(color: kintroselected),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: hp(3)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.web_asset,
                                          color: Colors.red[400],
                                        ),
                                        SizedBox(
                                          width: hp(2),
                                        ),
                                        Text('MLS-123'),
                                      ],
                                    ),
                                    Icon(FontAwesomeIcons.motorcycle)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

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
                      Container(
                        height: hp(16),
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final orderedProducts = ordersProductsFollowing
                                  .selectedProducts[index];
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
                                                    Text(
                                                      'Listo para entrega',
                                                      style: TextStyle(
                                                          color:
                                                              kstockAvailable,
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
                            itemCount: ordersProductsFollowing
                                .selectedProducts.length),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      Container(
                        height: size.height * 0.09,
                        child: Card(
                          elevation: 7,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
