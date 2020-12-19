import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/botton_sheet.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/Category/category_page.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/pages/ProductImage/product_image_page.dart';
import 'package:service_products_business/pages/Stock/stock_page.dart';
import 'package:service_products_business/widgets/custom_fab.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/header.dart';
import 'package:service_products_business/widgets/product_custom_input.dart';

// ignore: must_be_immutable
class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController name = TextEditingController();

  TextEditingController info = TextEditingController();

  TextEditingController normalPrice = TextEditingController();

  TextEditingController offertPrice = TextEditingController();

  TextEditingController uniqueStock = TextEditingController();

  FocusNode fproductname;
  FocusNode fdescription;
  FocusNode fquantity;
  FocusNode fnormalprice;
  FocusNode fofferprice;

  @override
  void initState() {
    super.initState();
    fproductname = FocusNode();
    fdescription = FocusNode();
    fquantity = FocusNode();
    fnormalprice = FocusNode();
    fofferprice = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    fproductname.dispose();
    fdescription.dispose();
    fquantity.dispose();
    fnormalprice.dispose();
    fofferprice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        wp: wp,
        onPressed: () =>
            CustomRouteTransition(context: context, child: ProductImagePage()),
        text: 'Siguiente',
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
            child: Container(
          child: Column(
            children: [
              Header(
                title: 'Nuevo producto',
                subtitle: '1/2',
                dialogTitle:
                    'Se descartará la informacion de tu\n nuevo producto',
                function: () {
                  CustomRouteTransition(
                      replacement: true, context: context, child: MainPage());
                  BlocProvider.of<ProductsBloc>(context)
                      .add(OnCleanProductData());
                },
              ),
              //PRODUCT INFORMATION
              BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  return _form(hp, wp, context, state);
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  Container _form(
      Function hp, Function wp, BuildContext context, ProductsState state) {
    return Container(
      height: hp(76),
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Text('Información de producto',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          //NAME
          CustomInput(
              autofocus: false,
              focusNode: fproductname,
              textInputAction: TextInputAction.next,
              onFocus: () {
                fproductname.unfocus();
                FocusScope.of(context).requestFocus(fdescription);
              },
              keyboardType: TextInputType.text,
              function: (value) => BlocProvider.of<ProductsBloc>(context)
                  .add(OnNameChanged(value)),
              hp: hp(7),
              placeholder: 'Nombre',
              textEditingController: name),
          //DESCRIPTION
          CustomInput(
            autofocus: false,
            focusNode: fdescription,
            textInputAction: TextInputAction.next,
            onFocus: () {
              fdescription.unfocus();
              FocusScope.of(context).requestFocus(fquantity);
            },
            function: (value) => BlocProvider.of<ProductsBloc>(context)
                .add(OnDescriptionChange(value)),
            placeholder: 'Informacion',
            keyboardType: TextInputType.multiline,
            textEditingController: info,
            maxlines: 6,
            hp: hp(25),
            hintMaxLines: 4,
          ),
          //CATEGORY
          GestureDetector(
            onTap: () => CustomRouteTransition(
                context: context,
                child: CategoryPage(),
                animation: AnimationType.fadeIn),
            child: Container(
              height: hp(7),
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.grey[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${handleProductCategory(state.category)}- ${handleProductSubcategory(state.subCategory)}',
                    style: GoogleFonts.oswald(
                        color: Colors.black, fontSize: wp(4.5)),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: wp(5),
                  ),
                ],
              ),
            ),
          ),

          Text('Stock',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          //STOCK TYPE
          ProductCustomInput(
            hp: hp(7),
            fontSize: wp(4),
            iconSize: wp(6),
            function: () => displayModalBottomSheetStock(context),
            text: state.stocktype != null
                ? handleStockType(state.stocktype)
                : 'Unico',
            icon: Icons.keyboard_arrow_down,
          ),
          //ADMIN STOCK TYPE
          state.stocktype == StockType.UNIQUE
              ? CustomInput(
                  autofocus: false,
                  focusNode: fquantity,
                  textInputAction: TextInputAction.next,
                  onFocus: () {
                    fquantity.unfocus();
                    FocusScope.of(context).requestFocus(fnormalprice);
                  },
                  placeholder: 'Cantidad',
                  textEditingController: uniqueStock,
                  function: (value) => BlocProvider.of<ProductsBloc>(context)
                      .add(OnStockChange(value, 0)),
                  keyboardType: TextInputType.number,
                )
              : GestureDetector(
                  onTap: () => CustomRouteTransition(
                      context: context, child: StockPage()),
                  child: Container(
                    height: hp(7),
                    margin: EdgeInsets.only(bottom: 20),
                    padding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          state.adminStockType != null
                              ? handleAdminStockType(state.adminStockType)
                              : 'Cantidad',
                          style: GoogleFonts.oswald(
                              color: state.adminStockType != null
                                  ? kintroselected
                                  : kintroNotSelected,
                              fontSize: wp(4.5)),
                        ),
                        Icon(
                          state.adminStockType != null
                              ? Icons.arrow_forward_ios
                              : Icons.keyboard_arrow_down,
                          size: 23,
                          color: state.adminStockType != null
                              ? kintroselected
                              : kintroNotSelected,
                        ),
                      ],
                    ),
                  ),
                ),
          Text('Precio',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          //PRICE TYPE
          ProductCustomInput(
            fontSize: wp(4),
            iconSize: wp(5),
            hp: hp(7),
            function: () => displayModalBottomSheetPrice(context),
            icon: Icons.arrow_forward_ios,
            text: state.priceType != null
                ? handlePriceType(state.priceType)
                : 'Normal',
          ),
          //NORMAL PRICE
          CustomInput(
              autofocus: false,
              keyboardType: TextInputType.number,
              focusNode: fnormalprice,
              textInputAction: state.priceType == PriceType.OFFERT
                  ? TextInputAction.next
                  : TextInputAction.done,
              onFocus: () {
                fnormalprice.unfocus();
                FocusScope.of(context).requestFocus(fofferprice);
              },
              hp: hp(7),
              function: (value) => BlocProvider.of<ProductsBloc>(context)
                  .add(OnNormalPriceChange(value)),
              placeholder: 'Precio Normal (S/)',
              textEditingController: normalPrice),
          state.priceType == PriceType.OFFERT
              ? CustomInput(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  focusNode: fofferprice,
                  textInputAction: TextInputAction.done,
                  onFocus: () {
                    fofferprice.unfocus();
                  },
                  hp: hp(7),
                  function: (value) => BlocProvider.of<ProductsBloc>(context)
                      .add(OnOfferPriceChange(value)),
                  placeholder: 'Precio Oferta (S/)',
                  textEditingController: offertPrice)
              : Container()
        ],
      ),
    );
  }

  // Widget _header(BuildContext context) {
  //   return Material(
  //     elevation: 5,
  //     child: Container(
  //       margin: EdgeInsets.only(left: 5, right: 10),
  //       height: 50,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Row(
  //             children: [
  //               IconButton(
  //                   icon: Icon(Icons.arrow_back),
  //                   onPressed: () {
  //                     showDiscardProduct(
  //                       context,

  //                       title:
  //                           'Se descartará la informacion de tu\n nuevo producto',
  //                     );
  //                   }),
  //               Text(
  //                 'Nuevo producto',
  //                 style: GoogleFonts.lato(
  //                     fontWeight: FontWeight.bold, fontSize: 15),
  //               ),
  //             ],
  //           ),
  //           Container(
  //             height: 30,
  //             width: 60,
  //             child: Center(
  //                 child: Text(
  //               '1/2',
  //               style: GoogleFonts.lato(color: kprimarycolorlight),
  //             )),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20),
  //               gradient: LinearGradient(
  //                 begin: Alignment.centerLeft,
  //                 end: Alignment.centerRight,
  //                 colors: [
  //                   primaryColor,
  //                   secondaryColor,
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
