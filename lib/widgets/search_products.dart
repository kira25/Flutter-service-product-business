import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/controller/editproduct_controller.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/models/AdminProduct/admin_product.dart';
import 'package:service_products_business/models/product_response.dart';
import 'package:service_products_business/pages/EditProduct/edit_product_page.dart';

class SearchProducts extends SearchDelegate {
  SearchProducts(this.listProducts, this.hp, this.wp);

  final List<Product> listProducts;
  final Function hp;
  final Function wp;

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

  String selectedResult;

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Text(selectedResult),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final controller = Get.put(EditProductController());
    List<Product> suggestionList = [];
    query.isEmpty
        ? suggestionList = []
        : suggestionList.addAll(
            listProducts.where((element) => element.name.contains(query)));

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
                      List<AdminProduct> list2 = [];
                      if (suggestionList[index].stock.length != 0) {
                        List<Map<String, dynamic>> list = suggestionList[index]
                            .stock
                            .map((e) => e.toJson())
                            .toList();
                        print(list);

                        list2 = list
                            .map((e) => AdminProduct.fromJsonAdmin(e))
                            .toList();
                      }

                      controller.setDataToEdit(
                          handleIntToStockType(suggestionList[index].stockType),
                          handleIntToStockType(
                                      suggestionList[index].stockType) ==
                                  StockType.UNIQUE
                              ? AdminStockType.ADMIN_STOCK_UNIQUE
                              : handleIntToStockType(
                                          suggestionList[index].stockType) ==
                                      StockType.BY_COLOR
                                  ? AdminStockType.ADMIN_STOCK_COLOR
                                  : handleIntToStockType(suggestionList[index]
                                              .stockType) ==
                                          StockType.BY_SIZE
                                      ? AdminStockType.ADMIN_STOCK_BY_SIZE
                                      : handleIntToStockType(
                                                  suggestionList[index]
                                                      .stockType) ==
                                              StockType.BY_COLOR_SIZE
                                          ? AdminStockType
                                              .ADMIN_STOCK_BY_COLOR_SIZE
                                          : AdminStockType.ADMIN_STOCK_UNIQUE,
                          handleIntToPriceType(suggestionList[index].priceType),
                          suggestionList[index].price.normalPrice.toString(),
                          suggestionList[index].price.offertPrice.toString(),
                          suggestionList[index].stock);

                      controller.setAdminStock(list2);

                      CustomRouteTransition(
                          context: context,
                          child: EditProductPage(
                            name: suggestionList[index].name,
                            id: suggestionList[index].id,
                            adminStock: list2,
                          ),
                          animation: AnimationType.fadeIn);
                    },
                  ),
                  IconSlideAction(
                    color: kwrongAnswer,
                    iconWidget: Icon(
                      FontAwesomeIcons.trash,
                      size: wp(8),
                      color: kprimarycolorlight,
                    ),
                    onTap: () => BlocProvider.of<ProductsBloc>(context)
                        .add(OnDeleteProduct(suggestionList[index].id)),
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
                          suggestionList[index].imageProduct.isEmpty
                              ? Container()
                              : Image.network(
                                  suggestionList[index].imageProduct[0].product,
                                  height: hp(15),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
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
                          Text(
                            suggestionList[index].name,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: wp(4.5)),
                          ),
                          suggestionList[index].price.offertPrice != null
                              ? Text(
                                  'Precio Oferta : S/ ${suggestionList[index].price.offertPrice}',
                                  style: GoogleFonts.lato(fontSize: wp(3.5)),
                                )
                              : Text(
                                  'Precio Normal : S/ ${suggestionList[index].price.normalPrice}',
                                  style: GoogleFonts.lato(fontSize: wp(3.5)),
                                ),
                          RichText(
                            text: TextSpan(
                                text: 'Stock ',
                                style: GoogleFonts.lato(
                                    textStyle:
                                        TextStyle(color: kintroNotSelected),
                                    fontSize: wp(3.5)),
                                children: [
                                  suggestionList[index].amountStock != 0
                                      ? TextSpan(
                                          text: 'Disponible',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: kstockAvailable)))
                                      : TextSpan(
                                          text:
                                              'Algunas tallas o colores sin stock',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: kwrongAnswer)))
                                ]),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: kintroselected,
                                borderRadius: BorderRadius.circular(20)),
                            height: hp(3),
                            width: wp(25),
                            child: Center(
                              child: Text(
                                handleProductCategoryFromResponse(
                                    suggestionList[index]
                                        .productCategory
                                        .subcategory),
                                style: GoogleFonts.lato(
                                    color: kprimarycolorlight, fontSize: wp(4)),
                              ),
                            ),
                          )
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
            ),
        itemCount: suggestionList.length);
  }
}
