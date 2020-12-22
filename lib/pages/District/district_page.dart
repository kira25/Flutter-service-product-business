import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/controller/editservices_controller.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/widgets/category_options.dart';

class DistrictPage extends StatelessWidget {
      final c = Get.put(EditServicesController());

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
          title: Text('Selecciona distrito',
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
                  option: 'Jesus Maria',
                  function: args["isEdit"] == true
                      ? () {
                          c.onDistrictType(DistrictType.JESUSMARIA);
                          Navigator.pop(context);
                        }
                      : () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDistrictType(DistrictType.JESUSMARIA));
                    Navigator.pop(context);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Lince',
                  function:  args["isEdit"] == true
                      ? () {
                          c.onDistrictType(DistrictType.LINCE);
                          Navigator.pop(context);
                        }
                      : () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDistrictType(DistrictType.LINCE));
                    Navigator.pop(context);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'La Molina',
                  function: args["isEdit"] == true
                      ? () {
                          c.onDistrictType(DistrictType.MOLINA);
                          Navigator.pop(context);
                        }
                      :  () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDistrictType(DistrictType.MOLINA));
                    Navigator.pop(context);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'San Borja',
                  function:  args["isEdit"] == true
                      ? () {
                          c.onDistrictType(DistrictType.SANBORJA);
                          Navigator.pop(context);
                        }
                      : () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDistrictType(DistrictType.SANBORJA));
                    Navigator.pop(context);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'San Isidro',
                  function: args["isEdit"] == true
                      ? () {
                          c.onDistrictType(DistrictType.SANISIDRO);
                          Navigator.pop(context);
                        }
                      :  () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDistrictType(DistrictType.SANISIDRO));
                    Navigator.pop(context);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Surco',
                  function: args["isEdit"] == true
                      ? () {
                          c.onDistrictType(DistrictType.SURCO);
                          Navigator.pop(context);
                        }
                      :  () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDistrictType(DistrictType.SURCO));
                    Navigator.pop(context);
                  }),
              CategoryOptions(
                border: false,
                  wp: wp,
                  option: 'Surquillo',
                  function:  args["isEdit"] == true
                      ? () {
                          c.onDistrictType(DistrictType.SURQUILLO);
                          Navigator.pop(context);
                        }
                      : () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDistrictType(DistrictType.SURQUILLO));
                    Navigator.pop(context);
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
