import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/controller/editproduct_controller.dart';
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

class EditProductPage extends StatelessWidget {
  final String normalPrice;
  final String offerPrice;
  final List<Stock> stock;
  final List<AdminProduct> adminStock;
  final StockType stockType;
  final PriceType priceType;
  final String id;
  final String name;
  final AdminStockType adminStockType;

  EditProductPage({
    this.normalPrice,
    this.offerPrice,
    this.stock,
    this.adminStock,
    this.stockType,
    this.priceType,
    this.id,
    this.name,
    this.adminStockType,
  });

  final c = Get.put(EditProductController());

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: kprimarycolorlight,
        title: Text(
          'Editar Producto',
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: wp(4.5),
              color: kdarkcolor),
        ),
        leading: IconButton(
            color: kdarkcolor,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              CustomRouteTransition(
                  replacement: true, context: context, child: MainPage());
              // BlocProvider.of<ProductsBloc>(context)
              //     .add(OnCleanProductData());
              c.cleanProductData();
            }),
      ),
      floatingActionButton: CustomFloatingActionButton(
        wp: wp,
        onPressed: () async {
          final resp = await c.updateProduct(
              id,
              c.stockType.value,
              c.adminStock,
              c.priceType.value.index,
              c.normalPrice.value.text,
              c.offerPrice.value.text);
          print('product updated');

          if (resp) {
            showAlert(context,
                title: 'Producto actualizado',
                subtitle: 'Aceptar',
                child: MainPage());
          } else {
            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                      title: new Text("Datos incorrectos"),
                    ));
          }
        },
        text: 'Completar',
      ),
      body: GetX<EditProductController>(
        builder: (controller) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Container(
              height: hp(90),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$name',
                      style: GoogleFonts.lato(
                        fontSize: wp(4.5),
                        fontWeight: FontWeight.bold,
                      )),
                  _form(context, hp, wp, controller)
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget _form(BuildContext context, Function hp, Function wp,
      EditProductController controller) {
    return Container(
      height: hp(70),
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
            
            // isCompleted: state.stocktype != StockType.UNDEFINED ? true : false,
            hp: hp(7),
            fontSize: wp(4),
            iconSize: wp(6),
            text: handleStockType(controller.stockType.value),
            icon: Icons.keyboard_arrow_down,
          ),
          //ADMIN STOCK TYPE
          controller.stockType.value == StockType.UNIQUE
              ? CustomInput(
                autofocus: false,
                  hp: hp(7),
                  focusNode: controller.fquantity,
                  textInputAction: TextInputAction.next,
                  onFocus: () {
                    controller.fquantity.unfocus();
                    FocusScope.of(context)
                        .requestFocus(controller.fnormalprice);
                  },
                  placeholder: 'Cantidad',
                  textEditingController: controller.uniqueStockController.value,
                  function: (value) => controller.setAdminProduct(0, value),
                  keyboardType: TextInputType.number,
                )
              : GestureDetector(
                  onTap: () => CustomRouteTransition(
                    animation: AnimationType.fadeIn,
                      context: context,
                      child: StockPage(
                        isEdited: true,
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
                          handleAdminStockType(controller.adminStockType.value),
                          style: GoogleFonts.oswald(
                              color: controller.adminStockType.value !=
                                      AdminStockType.UNDEFINED
                                  ? kintroselected
                                  : kintroNotSelected,
                              fontSize: wp(4.5)),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: wp(5),
                          color: controller.adminStockType.value !=
                                  AdminStockType.UNDEFINED
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
              function: () =>
                  displayModalBottomSheetPriceToEditProduct(context),
              icon: Icons.arrow_forward_ios,
              text: handlePriceType(controller.priceType.value)),
          //NORMAL PRICE
          CustomInput(                autofocus: false,

              keyboardType: TextInputType.number,
              focusNode: controller.fnormalprice,
              textInputAction: controller.priceType.value == PriceType.OFFERT
                  ? TextInputAction.next
                  : TextInputAction.done,
              onFocus: () {
                controller.fnormalprice.unfocus();
                FocusScope.of(context).requestFocus(controller.fofferprice);
              },
              hp: hp(7),
              function: (value) => controller.setnormalPrice(value),
              placeholder: 'Precio Normal (S/)',
              textEditingController: controller.normalPrice.value),
          controller.priceType.value == PriceType.OFFERT
              ? CustomInput(                autofocus: false,

                  keyboardType: TextInputType.number,
                  focusNode: controller.fofferprice,
                  textInputAction: TextInputAction.done,
                  onFocus: () {
                    controller.fofferprice.unfocus();
                  },
                  hp: hp(7),
                  function: (value) => controller.setofferPrice(value),
                  placeholder: 'Precio Oferta (S/)',
                  textEditingController: controller.offerPrice.value)
              : Container()
        ],
      ),
    );
  }
}
