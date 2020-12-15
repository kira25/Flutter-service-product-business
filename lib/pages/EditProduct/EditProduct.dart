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
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/models/AdminProduct/admin_product.dart';
import 'package:service_products_business/models/product_response.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/pages/Stock/stock_page.dart';
import 'package:service_products_business/widgets/custom_fab.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/product_custom_input.dart';

class EditProduct extends StatefulWidget {
  final String normalPrice;
  final String offerPrice;
  final List<Stock> stock;
  final List<AdminProduct> adminStock;
  final StockType stockType;
  final PriceType priceType;
  final String id;
  final String name;
  final ProductsState state;

  const EditProduct(
      {this.normalPrice,
      this.offerPrice,
      this.stock,
      this.adminStock,
      this.stockType,
      this.priceType,
      this.id,
      this.name,
      this.state});

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController uniqueStock;

  TextEditingController normalPrice;

  TextEditingController offertPrice;

  FocusNode fquantity;
  FocusNode fnormalprice;
  FocusNode fofferprice;

  @override
  void initState() {
    super.initState();

    normalPrice = TextEditingController(text: widget.normalPrice);
    offertPrice = TextEditingController(
        text: widget.offerPrice != "null" ? widget.offerPrice : '');
    uniqueStock = TextEditingController(
        text: widget.stock[0].quantity != null && widget.stock[0].color == null
            ? widget.stock[0].quantity.toString()
            : '');
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
        onPressed: () => BlocProvider.of<ProductsBloc>(context)
            .add(OnUpdateProduct(widget.id)),
        text: 'Completar',
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: BlocListener<ProductsBloc, ProductsState>(
          listener: (_, state) {
            if (state.isProductEdited == IsProductEdited.SUCCESS) {
              showAlert(context,
                  title: 'Producto creado con exito',
                  subtitle: 'Aceptar',
                  child: MainPage());
              BlocProvider.of<ProductsBloc>(context).add(OnCleanProductData());
            } else if (state.isProductEdited == IsProductEdited.FAIL) {
              showDialog(
                  context: _,
                  builder: (_) => new AlertDialog(
                        title: new Text("Product already exist"),
                      ));
            }
          },
          child: SafeArea(
              child: Container(
            child: Column(
              children: [
                _header(context, hp, wp),
                SizedBox(
                  height: hp(3),
                ),
                Text('${widget.name}',
                    style: GoogleFonts.lato(
                      fontSize: wp(4.5),
                      fontWeight: FontWeight.bold,
                    )),
                BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                  return _form(context, hp, wp,  state);
                })
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _form(
      BuildContext context, Function hp, Function wp, ProductsState state) {
    return Container(
      height: hp(76),
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Stock',
              style: GoogleFonts.lato(color: Colors.black, fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          //STOCK TYPE
          ProductCustomInput(
            isCompleted: state.stocktype != null ? true : false,
            hp: hp(7),
            fontSize: wp(4),
            iconSize: wp(5),
            function: () => displayModalBottomSheetStock(context),
            text: handleStockType(state.stocktype),
            icon: Icons.keyboard_arrow_down,
          ),
          //ADMIN STOCK TYPE
          state.stocktype == StockType.UNIQUE
              ? CustomInput(
                  hp: hp(7),
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
                      context: context,
                      child: StockPage(
                        adminStock: widget.adminStock,
                      )),
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
                          handleAdminStockType(state.adminStockType),
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
              style: GoogleFonts.lato(color: Colors.black, fontSize: wp(4.5))),
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
              text: handlePriceType(state.priceType)),
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
                    onPressed: () {
                      CustomRouteTransition(
                          replacement: true,
                          context: context,
                          child: MainPage());
                      BlocProvider.of<ProductsBloc>(context)
                          .add(OnCleanProductData());
                    }),
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
