import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/pages/Department/department_page.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/pages/ServiceImage/service_image_page.dart';
import 'package:service_products_business/widgets/custom_fab.dart';
import 'package:service_products_business/widgets/custom_input.dart';
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

  FocusNode fproductname;
  FocusNode fdescription;
  FocusNode fnormalprice;
  FocusNode fofferprice;
  @override
  void initState() {
    super.initState();
    fproductname = FocusNode();
    fdescription = FocusNode();
    fnormalprice = FocusNode();
    fofferprice = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    fproductname.dispose();
    fdescription.dispose();
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
            CustomRouteTransition(context: context, child: ServiceImagePage()),
        text: 'Siguiente',
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
            child: Container(
          child: Column(
            children: [
              Header(
                title: 'Nuevo servicio',
                subtitle: '1/2',
                dialogTitle:
                    'Se descartará la informacion de tu\n nuevo producto',
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
      child: ListView(
        physics: BouncingScrollPhysics(),
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
            focusNode: fdescription,
            textInputAction: TextInputAction.next,
            onFocus: () {
              fdescription.unfocus();
            },
            placeholder: 'Informacion',
            keyboardType: TextInputType.multiline,
            textEditingController: info,
            maxlines: 6,
            hp: hp(25),
            hintMaxLines: 4,
          ),
          //DeliveryTIME
          DropdownButtonHideUnderline(
            child: DropdownButton(
                value: '1 hrs',
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
                onChanged: (value) => print(value)),
          ),
          //ATTENTION HOURS
          CustomInput(
              placeholder: 'Horario de atencion',
              textEditingController: attentionHours),

          Text('Disponibilidad',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          ProductCustomInput(
            wp: wp,
            hp: hp(7),
            text: 'En tienda',
          ),
          SizedBox(
            height: hp(3),
          ),
          //STOCK TYPE

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
                  placeholder: 'Precio Oferta (S/)',
                  textEditingController: offertPrice)
              : Container()
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dialogTitle;
  const Header({
    Key key,
    this.title,
    this.subtitle,
    this.dialogTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      showDiscardProduct(
                        context,
                        child: MainPage(),
                        title: dialogTitle,
                      );
                    }),
                Text(
                  title,
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
                subtitle,
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
