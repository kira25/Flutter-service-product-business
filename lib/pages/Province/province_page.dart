import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/controller/editservices_controller.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/routes/routes.dart';
import 'package:service_products_business/widgets/category_options.dart';

class ProvincePage extends StatelessWidget {
    final c = Get.put(EditServicesController());
    final bool isEdit;

   ProvincePage({ this.isEdit= false});

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    Map args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: kdarkcolor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: kprimarycolorlight,
          title: Text('Selecciona provincia',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, color: kdarkcolor))),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              CategoryOptions(
                  wp: wp,
                  option: 'Lima',
                  function: args["isEdit"] == true
                      ? () {
                          c.onProvinceType(ProvinceType.LIMA);
                          Navigator.popAndPushNamed(context, DISTRICT_PAGE,arguments: {"isEdit": true});
                        }
                      :() {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnProvinceType(ProvinceType.LIMA));
                    Navigator.popAndPushNamed(context, DISTRICT_PAGE,);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Nazca',
                  function:args["isEdit"] == true
                      ? () {
                          c.onProvinceType(ProvinceType.NAZCA);
                          Navigator.popAndPushNamed(context, DISTRICT_PAGE,arguments: {"isEdit": true});
                        }
                      : () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnProvinceType(ProvinceType.NAZCA));
                    Navigator.popAndPushNamed(context, DISTRICT_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Arequipa',
                  function: args["isEdit"] == true
                      ? () {
                          c.onProvinceType(ProvinceType.AREQUIPA);
                          Navigator.popAndPushNamed(context, DISTRICT_PAGE,arguments: {"isEdit": true});
                        }
                      : () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnProvinceType(ProvinceType.AREQUIPA));
                    Navigator.popAndPushNamed(context, DISTRICT_PAGE);
                  }),
              CategoryOptions(
                  border: false,
                  wp: wp,
                  option: 'Chiclayo',
                  function: args["isEdit"] == true
                      ? () {
                          c.onProvinceType(ProvinceType.CHICLAYO);
                          Navigator.popAndPushNamed(context, DISTRICT_PAGE,arguments: {"isEdit": true});
                        }
                      :() {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnProvinceType(ProvinceType.CHICLAYO));
                    Navigator.popAndPushNamed(context, DISTRICT_PAGE);
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
