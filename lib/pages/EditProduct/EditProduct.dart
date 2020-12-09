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
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/pages/Stock/stock_page.dart';
import 'package:service_products_business/widgets/custom_fab.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/product_custom_input.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController uniqueStock = TextEditingController();

  TextEditingController normalPrice = TextEditingController();

  TextEditingController offertPrice = TextEditingController();
  FocusNode fquantity;
  FocusNode fnormalprice;
  FocusNode fofferprice;

  @override
  void initState() {
    super.initState();
    fquantity = FocusNode();
    fnormalprice = FocusNode();
    fofferprice = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
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
            CustomRouteTransition(context: context, child: MainPage()),
        text: 'Completar',
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
            child: Container(
          child: Column(
            children: [
              _header(context, hp, wp),
              BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                return _form(context, hp, wp, state);
              })
            ],
          ),
        )),
      ),
    );
  }

  Widget _form(
      BuildContext context, Function hp, Function wp, ProductsState state) {
    return Container(
      height: hp(76),
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
        children: [
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
            wp: wp,
            function: () => displayModalBottomSheetStock(context),
            text: state.stocktype != null
                ? handleStockType(state.stocktype)
                : 'Unico',
            icon: Icons.keyboard_arrow_down,
          ),
          //ADMIN STOCK TYPE
          state.stocktype == StockType.UNIQUE
              ? CustomInput(
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

  Widget _header(BuildContext context, Function hp, Function wp) {
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
                        child: MainPage())),
                Text(
                  'Editar Producto',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: wp(4.5)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
