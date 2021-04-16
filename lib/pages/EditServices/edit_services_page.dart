import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/controller/editservices_controller.dart';
import 'package:service_products_business/helpers/botton_sheet.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/helpers/services.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/pages/Department/department_page.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/widgets/custom_fab.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/product_custom_input.dart';

class EditServicesPage extends StatelessWidget {
  final c = Get.put(EditServicesController());
  final String id;

  EditServicesPage({this.id});
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        wp: wp,
        onPressed: () async {
          final resp = await c.onUpdateServices(
              c.deliveryTime.value.text,
              c.attentionHours.value.text,
              c.availableType.value,
              c.departmentType.value,
              c.provinceType.value,
              c.districtType.value,
              c.address.value.text,
              c.districtAvailable,
              c.priceType.value,
              c.normalPrice.value.text,
              c.offerPrice.value.text,
              id);
          // final resp = await c.updateProduct(
          //     id,
          //     c.stockType.value,
          //     c.adminStock,
          //     c.priceType.value.index,
          //     c.normalPrice.value.text,
          //     c.offerPrice.value.text);
          print('product updated');

          if (resp) {
            showAlert(context,
                title: 'Servicio actualizado',
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
      appBar: AppBar(
        elevation: 4,
        backgroundColor: kprimarycolorlight,
        title: Text(
          'Editar Servicio',
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
            }),
      ),
      body: GetX<EditServicesController>(
        init: EditServicesController(),
        builder: (controller) {
          return SafeArea(
              child: SingleChildScrollView(
            child: Container(
              height: hp(85),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: hp(3)),
                    child: Text('${controller.name}',
                        style: GoogleFonts.lato(
                          fontSize: wp(4.5),
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  _form(context, hp, wp, controller),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget _form(BuildContext context, Function hp, Function wp,
      EditServicesController controller) {
    return Container(
      height: hp(70),
      margin: EdgeInsets.symmetric(horizontal: wp(6)),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Text('Tiempo de entrega',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          Container(
            height: hp(8),
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: DropdownButtonFormField(
                value: controller.deliveryTime.value.text,
                focusNode: controller.fdelivery,
                decoration: InputDecoration(
                    hintText: 'Tiempo aprox.', border: InputBorder.none),
                items: [
                  DropdownMenuItem(
                    child: Text('1 hrs'),
                    value: '1 hrs',
                  ),
                  DropdownMenuItem(
                    child: Text('2 hrs'),
                    value: '2 hrs',
                  ),
                  DropdownMenuItem(
                    child: Text('3 hrs'),
                    value: '3 hrs',
                  ),
                  DropdownMenuItem(
                    child: Text('4 hrs'),
                    value: '4 hrs',
                  ),
                  DropdownMenuItem(
                    child: Text('5 hrs'),
                    value: '5 hrs',
                  ),
                ],
                onChanged: (value) => controller.onServiceDeliveryTime(value)),
          ),
          SizedBox(
            height: hp(3),
          ),
          Text('Horario de atención',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          CustomInput(
              autofocus: false,
              function: (value) => controller.onAttentionHours(value),
              focusNode: controller.fattention,
              onFocus: () {
                controller.fattention.unfocus();
              },
              hp: hp(7),
              textInputAction: TextInputAction.next,
              placeholder: 'Horario de atencion(Lun a Vie 5am a 6pm)',
              textEditingController: controller.attentionHours.value),
          Text('Disponibilidad',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          ProductCustomInput(
            icon: Icons.keyboard_arrow_down,
            function: () => displayModalBottomSheetAvailableTypeToEdit(context),
            fontSize: wp(4),
            iconSize: wp(6),
            hp: hp(7),
            isCompleted: controller.availableType != null ? true : false,
            text: handleAvailableType(controller.availableType.value),
          ),
          controller.availableType.value == AvailableType.HOME
              ? Container()
              : GestureDetector(
                  onTap: () => CustomRouteTransition(
                      context: context,
                      child: DepartmentPage(
                        isEdit: true,
                      ),
                      animation: AnimationType.fadeIn),
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
                          '${handleDepartmentType(controller.departmentType.value)}- ${handleProvinceType(controller.provinceType.value)}- ${handleDistrictType(controller.districtType.value)}',
                          style: GoogleFonts.lato(
                              color: controller.departmentType == null
                                  ? kintroNotSelected
                                  : kdarkcolor,
                              fontSize: wp(4)),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: wp(4),
                        ),
                      ],
                    ),
                  ),
                ),
          controller.availableType.value == AvailableType.HOME
              ? Container()
              : CustomInput(
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  function: (value) => controller.onAddressChange(value),
                  focusNode: controller.faddress,
                  onFocus: () {
                    controller.faddress.unfocus();
                    FocusScope.of(context)
                        .requestFocus(controller.fnormalprice);
                  },
                  textInputAction: TextInputAction.next,
                  hp: hp(7),
                  placeholder: 'Direccion',
                  textEditingController: controller.address.value),
          controller.availableType.value == AvailableType.SHOP_HOME ||
                  controller.availableType.value == AvailableType.HOME
              ? GetBuilder<EditServicesController>(
                  init: EditServicesController(),
                  builder: (editcontroller) {
                    return ProductCustomInput(
                      icon: Icons.keyboard_arrow_down,
                      function: () =>
                          displayModalBottomSheetDistrictAvailableToEdit(
                              context),
                      fontSize: wp(3.8),
                      iconSize: wp(6),
                      hp: hp(7),
                      isCompleted:
                          editcontroller.districts.isNotEmpty ? true : false,
                      text: controller.districtAvailable.isNotEmpty
                          ? controller.districtAvailable
                              .map((e) => handleDistrictType(e))
                              .toString()
                          : 'Disponibilidad en distritos (Domicilio)',
                    );
                  },
                )
              : Container(),
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
              iconSize: wp(4),
              function: () =>
                  displayModalBottomSheetPriceServiceToEdit(context),
              hp: hp(7),
              isCompleted: controller.priceType != null ? true : false,
              icon: Icons.arrow_forward_ios,
              text: handlePriceType(controller.priceType.value)),
          //NORMAL PRICE
          CustomInput(
              function: (value) => controller.onNormalPrice(value),
              autofocus: false,
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
              placeholder: 'Precio Normal (S/)',
              textEditingController: controller.normalPrice.value),
          controller.priceType.value == PriceType.OFFERT
              ? CustomInput(
                  function: (value) => controller.onOfferPrice(value),
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  focusNode: controller.fofferprice,
                  textInputAction: TextInputAction.done,
                  onFocus: () {
                    controller.fofferprice.unfocus();
                  },
                  hp: hp(7),
                  placeholder: 'Precio Oferta (S/)',
                  textEditingController: controller.offerPrice.value)
              : Container()
        ],
      ),
    );
  }
}
