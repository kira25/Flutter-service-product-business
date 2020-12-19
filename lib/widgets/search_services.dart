import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/services.dart';
import 'package:service_products_business/models/service_response.dart';

class SearchServices extends SearchDelegate {
  final List<Service> listServices;
  final Function hp;
  final Function wp;

  SearchServices(this.listServices, this.hp, this.wp);
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      Container(
        margin: EdgeInsets.only(right: wp(4)),
        child: CircleAvatar(
          backgroundColor: Color(0xFFf0f0f0),
          radius: 15,
          child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.close,
                size: wp(5),
                color: Color(0xFF8d8d8d),
              ),
              onPressed: () => query = ""),
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestionList = [];
    query.isEmpty
        ? suggestionList = []
        : suggestionList.addAll(
            listServices.where((element) => element.name.contains(query)));

    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            height: hp(25),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: hp(3), horizontal: wp(3)),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.20,
                secondaryActions: [
                  IconSlideAction(
                    color: kintroselected,
                    iconWidget: Icon(
                      Icons.edit,
                      size: wp(8),
                      color: kprimarycolorlight,
                    ),
                    onTap: () {
                      // List<AdminProduct> list2 = [];
                      // if (state.serviceResponse.service[index].stock.length != 0) {
                      //   List<Map<String, dynamic>> list = result[index]
                      //       .stock
                      //       .map((e) => e.toJson())
                      //       .toList();
                      //   print(list);

                      //   list2 = list
                      //       .map((e) => AdminProduct.fromJsonAdmin(e))
                      //       .toList();
                      // }

                      // CustomRouteTransition(
                      //     context: context,
                      //     child: EditProduct(
                      //       name: result[index].name,
                      //       id: result[index].id,
                      //       adminStock: list2,
                      //       priceType: handleIntToPriceType(
                      //           result[index].priceType),
                      //       stockType: handleIntToStockType(
                      //           result[index].stockType),
                      //       stock: result[index].stock,
                      //       normalPrice:
                      //           result[index].price.normalPrice.toString(),
                      //       offerPrice:
                      //           result[index].price.offertPrice.toString(),
                      //     ),
                      //     animation: AnimationType.fadeIn);
                    },
                  ),
                  IconSlideAction(
                    color: kwrongAnswer,
                    iconWidget: Icon(
                      FontAwesomeIcons.trash,
                      size: wp(8),
                      color: kprimarycolorlight,
                    ),
                    onTap: () => BlocProvider.of<ServicesBloc>(context)
                        .add(OnDeleteService(suggestionList[index].id)),
                  ),
                ],
                child: Row(
                  children: [
                    //IMAGE PRODUCT
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: wp(4), vertical: hp(1)),
                      width: wp(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          suggestionList[index].imageService.isEmpty
                              ? Container()
                              : Image.network(
                                  suggestionList[index].imageService[0].service,
                                  height: hp(15),
                                ),
                        ],
                      ),
                    ),
                    //PRODUCT DATA
                    Container(
                      width: wp(55),
                      padding: EdgeInsets.symmetric(vertical: hp(1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //NAME
                          Text(
                            suggestionList[index].name,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: wp(4.5)),
                          ),

                          //PRICE
                          suggestionList[index].price.offertPrice != null
                              ? RichText(
                                  text: TextSpan(
                                      text: 'Precio Oferta: ',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: kintroNotSelected),
                                          fontSize: wp(3.5)),
                                      children: [
                                        TextSpan(
                                            text:
                                                'S/ ${suggestionList[index].price.offertPrice}',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    color: kdarkcolor)))
                                      ]),
                                )
                              : RichText(
                                  text: TextSpan(
                                      text: 'Precio Normal: ',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: kintroNotSelected),
                                          fontSize: wp(3.5)),
                                      children: [
                                        TextSpan(
                                            text:
                                                'S/ ${suggestionList[index].price.normalPrice}',
                                            style: GoogleFonts.lato(
                                                textStyle: TextStyle(
                                                    color: kdarkcolor)))
                                      ]),
                                ),
                          RichText(
                            text: TextSpan(
                                text: 'Disponibilidad ',
                                style: GoogleFonts.lato(
                                    textStyle:
                                        TextStyle(color: kintroNotSelected),
                                    fontSize: wp(3.5)),
                                children: [
                                  TextSpan(
                                      text: handleIntToAvailableType(
                                          suggestionList[index].availableType),
                                      style: GoogleFonts.lato(
                                          textStyle:
                                              TextStyle(color: kdarkcolor)))
                                ]),
                          ),
                          SwitchListTile(
                            contentPadding: EdgeInsets.only(right: wp(5)),
                            dense: true,
                            activeColor: kdialogicon,
                            secondary: Text(
                              'Servicio disponible:',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.lato(fontSize: wp(3.5)),
                            ),
                            value: true,
                            onChanged: (bool value) {
                              print(value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(
              height: 10,
              color: kprimarycolorlight,
            ),
        itemCount: suggestionList.length);
  }
}
