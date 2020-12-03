import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/botton_sheet.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/Category/category_page.dart';
import 'package:service_products_business/pages/Orders/orders_page.dart';
import 'package:service_products_business/pages/ProductImage/product_image_page.dart';
import 'package:service_products_business/pages/Stock/stock_page.dart';
import 'package:service_products_business/widgets/custom_fab.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/product_custom_input.dart';

class AddProducts extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController info = TextEditingController();

  TextEditingController normalPrice = TextEditingController();
  TextEditingController offertPrice = TextEditingController();

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
              _header(context),
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
              keyboardType: TextInputType.text,
              function: (value) => BlocProvider.of<ProductsBloc>(context)
                  .add(OnNameChanged(value)),
              hp: hp(7),
              placeholder: 'Nombre',
              textEditingController: name),
          //DESCRIPTION
          CustomInput(
            function: (value) => BlocProvider.of<ProductsBloc>(context)
                .add(OnDescriptionChange(value)),
            placeholder: 'Informacion',
            keyboardType: TextInputType.multiline,
            textEditingController: info,
            maxlines: null,
            hp: hp(25),
            hintMaxLines: 4,
          ),
          //CATEGORY
          GestureDetector(
            onTap: () =>
                CustomRouteTransition(context: context, child: CategoryPage()),
            child: Container(
              height: hp(7),
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.grey[200],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state.category != null
                      ? Text(
                          '${handleProductCategory(state.category)}- ${handleProductSubcategory(state.subCategory)}')
                      : Text(
                          'Categoría - Subcategoría',
                          style: GoogleFonts.oswald(
                              color: Colors.black, fontSize: wp(4.5)),
                        ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 23,
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
          //STOCK TYPE
          ProductCustomInput(
            hp: hp(7),
            wp: wp,
            function: () => displayModalBottomSheetStock(context),
            text: state.stocktype != null
                ? handleStockType(state.stocktype)
                : 'Unico',
            icon: Icons.keyboard_arrow_down,
          ),
          //ADMIN STOCK TYPE
          GestureDetector(
            onTap: () =>
                CustomRouteTransition(context: context, child: StockPage()),
            child: Container(
              height: hp(7),
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
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
          //PRICE TYPE
          ProductCustomInput(
            wp: wp,
            hp: hp(7),
            function: () => displayModalBottomSheetPrice(context),
            icon: Icons.arrow_forward_ios,
            text: state.priceType != null
                ? handlePriceType(state.priceType)
                : 'Normal',
          ),
          //NORMAL PRICE
          CustomInput(
              hp: hp(7),
              function: (value) => BlocProvider.of<ProductsBloc>(context)
                  .add(OnNormalPriceChange(value)),
              placeholder: 'Precio Normal (S/)',
              textEditingController: normalPrice),
          state.priceType == PriceType.OFFERT
              ? CustomInput(
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

  Widget _header(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => CustomRouteTransition(
                        replacement: true,
                        context: context,
                        child: OrdersPage())),
                Text(
                  'Nuevo producto',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            Container(
              height: 30,
              width: 60,
              child: Center(
                  child: Text(
                '1/2',
                style: GoogleFonts.lato(color: kprimarycolorlight),
              )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    primaryColor,
                    secondaryColor,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
