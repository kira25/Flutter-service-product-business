import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:service_products_business/bloc/orders_products/orders_products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/models/OrderProduct_response.dart';
import 'package:service_products_business/pages/Main/components/orders_products_completed_details_page.dart';

class OrdersProductsCompleted extends StatefulWidget {
  final List<OrderProductResponse> listOrderProduct;
  final Function hp;

  OrdersProductsCompleted({Key key, this.listOrderProduct, this.hp})
      : super(key: key);

  @override
  _OrdersProductsCompletedState createState() => _OrdersProductsCompletedState();
}

class _OrdersProductsCompletedState extends State<OrdersProductsCompleted> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrdersProductsBloc>(context)
        .mapOnProductCompletedInitialListOrderProduct(
        list: widget.listOrderProduct,filter: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersProductsBloc,OrdersProductsState>(
      builder: (context, state) {
        final size = MediaQuery.of(context).size;

        return Expanded(
          child: Stack(
            children: [
              Container(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      final ordersCompleted = state.listCompletedProducts[index];

                      return GestureDetector(
                        onTap: () => CustomRouteTransition(
                            context: context,
                            child: OrdersProductsCompletedDetailsPage(
                              hp: widget.hp,
                              ordersProductsCompleted: ordersCompleted,
                              indexOrder: index,
                            )),
                        child: Container(
                          alignment: Alignment.center,
                          height: widget.hp(23),
                          child: Card(
                            elevation: 5,
                            margin: EdgeInsets.only(
                                top: widget.hp(2), bottom: widget.hp(3), left: widget.hp(3), right: widget.hp(3)),
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
                                        padding: EdgeInsets.only(right: widget.hp(3)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'ID ${ordersCompleted.id.toUpperCase().substring(0, 8)}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: widget.hp(2)),
                                            ),
                                            ordersCompleted.deliveryType ==
                                                    DeliveryType.CAR.index
                                                ? Icon(
                                                    FontAwesomeIcons.car,
                                                    size: 15,
                                                  )
                                                : Icon(
                                                    FontAwesomeIcons.motorcycle,
                                                    size: 15,
                                                  )
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
                                                      ' ${ordersCompleted.amountProducts}',
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
                                                  text: ' ${ordersCompleted.clientName}',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold))
                                            ]),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'S/.${ordersCompleted.totalPrice}',
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: widget.hp(2.5),
                                            width: widget.hp(20),
                                            margin: EdgeInsets.only(right: 15),
                                            child: Text(
                                              'PEDIDO ENTREGADO'.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: widget.hp(1.1),
                                                  color: kprimarycolorlight),
                                            ),
                                            color: kdialogicon,
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
                    itemCount: state.listCompletedProducts.length),
              ),
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
                                    'Pedidos completados',
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
                                                  .mapOnProductCompletedDateFilter(
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
                                          onTap: () => BlocProvider.of<OrdersProductsBloc>(context).mapOnProductCompletedInitialListOrderProduct(filter: true),
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
      }
    );
  }
}
