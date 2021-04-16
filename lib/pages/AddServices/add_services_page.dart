import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/helpers/botton_sheet.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/helpers/services.dart';
import 'package:service_products_business/pages/Department/department_page.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/pages/ServiceImage/service_image_page.dart';
import 'package:service_products_business/routes/routes.dart';
import 'package:service_products_business/widgets/custom_fab.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/header.dart';
import 'package:service_products_business/widgets/product_custom_input.dart';

class AddServicesPage extends StatefulWidget {
  @override
  _AddServicesPageState createState() => _AddServicesPageState();
}

class _AddServicesPageState extends State<AddServicesPage> {
  TextEditingController name = TextEditingController();
  TextEditingController attentionHours = TextEditingController();

  TextEditingController info = TextEditingController();

  TextEditingController normalPrice = TextEditingController();

  TextEditingController offertPrice = TextEditingController();
  TextEditingController address = TextEditingController();

  FocusNode fproductname;
  FocusNode fdescription;
  FocusNode fnormalprice;
  FocusNode fofferprice;
  FocusNode fattentionHours;
  FocusNode faddress;

  @override
  void initState() {
    super.initState();
    fproductname = FocusNode();
    fdescription = FocusNode();
    fnormalprice = FocusNode();
    fofferprice = FocusNode();
    fattentionHours = FocusNode();
    faddress = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    fproductname.dispose();
    fdescription.dispose();
    fnormalprice.dispose();
    fofferprice.dispose();
    fattentionHours.dispose();
    faddress.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        wp: wp,
        onPressed: () =>
            CustomRouteTransition(context: context, child: ServiceImagePage()),
        text: 'Siguiente',
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
            child: Container(
          child: ListView(
            children: [
              Header(
                function: () {
                  CustomRouteTransition(
                      replacement: true, context: context, child: MainPage());
                  BlocProvider.of<ServicesBloc>(context)
                      .add(OnCleanServiceData());
                },
                wp: wp(5),
                title: 'Nuevo servicio',
                subtitle: '1/2',
                dialogTitle:
                    'Se descartará la informacion de tu\n nuevo servicio',
              ),
              //PRODUCT INFORMATION
              BlocBuilder<ServicesBloc, ServicesState>(
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
      Function hp, Function wp, BuildContext context, ServicesState state) {
    return Container(
      height: hp(76),
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Column(
        children: [
          Text('Información de servicio',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          //NAME
          CustomInput(
              function: (value) => BlocProvider.of<ServicesBloc>(context)
                  .add(OnServiceNameChange(value)),
              autofocus: false,
              focusNode: fproductname,
              textInputAction: TextInputAction.next,
              onFocus: () {
                fproductname.unfocus();
                FocusScope.of(context).requestFocus(fdescription);
              },
              keyboardType: TextInputType.text,
              hp: hp(7),
              placeholder: 'Nombre',
              textEditingController: name),
          //DESCRIPTION
          CustomInput(
            autofocus: false,
            function: (value) => BlocProvider.of<ServicesBloc>(context)
                .add(OnServiceDescriptionChange(value)),
            focusNode: fdescription,
            textInputAction: TextInputAction.next,
            onFocus: () {
              fdescription.unfocus();
              FocusScope.of(context).requestFocus(fattentionHours);
            },
            placeholder: 'Informacion',
            textEditingController: info,
            maxlines: 6,
            hp: hp(25),
            hintMaxLines: 4,
          ),
          //DeliveryTIME
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
                onChanged: (value) => BlocProvider.of<ServicesBloc>(context)
                    .add(OnServiceDeliveryTime(value))),
          ),
          SizedBox(
            height: hp(3),
          ),
          //ATTENTION HOURS
          CustomInput(
              autofocus: false,
              function: (value) => BlocProvider.of<ServicesBloc>(context)
                  .add(OnAttentionHours(value)),
              focusNode: fattentionHours,
              onFocus: () {
                fattentionHours.unfocus();
              },
              hp: hp(7),
              textInputAction: TextInputAction.next,
              placeholder: 'Horario de atencion (Lun a Vie 5am a 6pm)',
              textEditingController: attentionHours),

          Text('Disponibilidad',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          //TIPO DE DISPONIBILIDAD
          ProductCustomInput(
            icon: Icons.keyboard_arrow_down,
            function: () => displayModalBottomSheetAvailableType(context),
            fontSize: wp(4),
            iconSize: wp(6),
            hp: hp(7),
            isCompleted: state.availableType != null ? true : false,
            text: handleAvailableType(state.availableType),
          ),
          //LOCATION
          state.availableType == AvailableType.HOME
              ? Container()
              : GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      FadeInRoute(
                          routeName: DEPARTMENT_PAGE, page: DepartmentPage())),
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
                          '${handleDepartmentType(state.departmentType)}- ${handleProvinceType(state.provinceType)}- ${handleDistrictType(state.districtType)}',
                          style: GoogleFonts.lato(
                              color: state.departmentType == null
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

          state.availableType == AvailableType.HOME
              ? Container()
              : CustomInput(
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  function: (value) => BlocProvider.of<ServicesBloc>(context)
                      .add(OnAddressChange(value)),
                  focusNode: faddress,
                  onFocus: () {
                    faddress.unfocus();
                    FocusScope.of(context).requestFocus(fnormalprice);
                  },
                  textInputAction: TextInputAction.next,
                  hp: hp(7),
                  placeholder: 'Direccion',
                  textEditingController: address),
          state.availableType == AvailableType.SHOP_HOME ||
                  state.availableType == AvailableType.HOME
              ? ProductCustomInput(
                  icon: Icons.keyboard_arrow_down,
                  function: () =>
                      displayModalBottomSheetDistrictAvailable(context),
                  fontSize: wp(3.8),
                  iconSize: wp(6),
                  hp: hp(7),
                  isCompleted:
                      state.districtAvailable.isNotEmpty ? true : false,
                  text: state.districtAvailable.isNotEmpty
                      ? state.districtAvailable
                          .map((e) => handleDistrictType(e))
                          .toString()
                      : 'Disponibilidad en distritos (Domicilio)',
                )
              : Container(),

          //PRICE TYPE
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
              function: () => displayModalBottomSheetPriceService(context),
              hp: hp(7),
              isCompleted: state.priceType != null ? true : false,
              icon: Icons.arrow_forward_ios,
              text: handlePriceType(state.priceType)),
          //NORMAL PRICE
          CustomInput(
              function: (value) => BlocProvider.of<ServicesBloc>(context)
                  .add(OnNormalPriceChange(value)),
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
              placeholder: 'Precio Normal (S/)',
              textEditingController: normalPrice),
          state.priceType == PriceType.OFFERT
              ? CustomInput(
                  function: (value) => BlocProvider.of<ServicesBloc>(context)
                      .add(OnOfferPriceChange(value)),
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  focusNode: fofferprice,
                  textInputAction: TextInputAction.done,
                  onFocus: () {
                    fofferprice.unfocus();
                  },
                  hp: hp(7),
                  placeholder: 'Precio Oferta (S/)',
                  textEditingController: offertPrice)
              : Container()
        ],
      ),
    );
  }
}
