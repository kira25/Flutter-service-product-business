import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/controller/editservices_controller.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/District/district_page.dart';
import 'package:service_products_business/routes/routes.dart';
import 'package:service_products_business/widgets/category_options.dart';

class ProvincePage extends StatelessWidget {
  final c = Get.put(EditServicesController());
  final bool isEdit;

  ProvincePage({this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;

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
                  function: isEdit == true
                      ? () {
                          c.onProvinceType(ProvinceType.LIMA);
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: DistrictPage(
                                    isEdit: true,
                                  ),
                                  routeName: DISTRICT_PAGE));
                        }
                      : () {
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnProvinceType(ProvinceType.LIMA));
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: DistrictPage(),
                                  routeName: DISTRICT_PAGE));

                        }),
              CategoryOptions(
                  wp: wp,
                  option: 'Nazca',
                  function: isEdit == true
                      ? () {
                          c.onProvinceType(ProvinceType.NAZCA);
                          FadeInRoute(
                              page: DistrictPage(
                                isEdit: true,
                              ),
                              routeName: DISTRICT_PAGE);
                        }
                      : () {
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnProvinceType(ProvinceType.NAZCA));
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: DistrictPage(),
                                  routeName: DISTRICT_PAGE));
                        }),
              CategoryOptions(
                  wp: wp,
                  option: 'Arequipa',
                  function: isEdit == true
                      ? () {
                          c.onProvinceType(ProvinceType.AREQUIPA);
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: DistrictPage(
                                    isEdit: true,
                                  ),
                                  routeName: DISTRICT_PAGE));
                        }
                      : () {
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnProvinceType(ProvinceType.AREQUIPA));
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: DistrictPage(),
                                  routeName: DISTRICT_PAGE));
                        }),
              CategoryOptions(
                  border: false,
                  wp: wp,
                  option: 'Chiclayo',
                  function: isEdit == true
                      ? () {
                          c.onProvinceType(ProvinceType.CHICLAYO);
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: DistrictPage(
                                    isEdit: true,
                                  ),
                                  routeName: DISTRICT_PAGE));
                        }
                      : () {
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnProvinceType(ProvinceType.CHICLAYO));
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: DistrictPage(),
                                  routeName: DISTRICT_PAGE));
                        }),
            ],
          ),
        )),
      ),
    );
  }
}
