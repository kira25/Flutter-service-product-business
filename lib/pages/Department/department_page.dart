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
import 'package:service_products_business/pages/Province/province_page.dart';
import 'package:service_products_business/routes/routes.dart';
import 'package:service_products_business/widgets/category_options.dart';

class DepartmentPage extends StatelessWidget {
  final c = Get.put(EditServicesController());

  final bool isEdit;

  DepartmentPage({this.isEdit = false});

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
          title: Text('Selecciona departamento',
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
                          c.onDepartmentType(DepartmentType.LIMA);
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: ProvincePage(
                                    isEdit: true,
                                  ),
                                  routeName: PROVINCE_PAGE));
                        }
                      : () {
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnDepartmentType(DepartmentType.LIMA));
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: ProvincePage(),
                                  routeName: PROVINCE_PAGE));
                        }),
              CategoryOptions(
                  wp: wp,
                  option: 'Arequipa',
                  function: isEdit == true
                      ? () {
                          c.onDepartmentType(DepartmentType.AREQUIPA);
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: ProvincePage(
                                    isEdit: true,
                                  ),
                                  routeName: PROVINCE_PAGE));
                        }
                      : () {
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnDepartmentType(DepartmentType.AREQUIPA));
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: ProvincePage(),
                                  routeName: PROVINCE_PAGE));
                        }),
              CategoryOptions(
                  wp: wp,
                  option: 'Ica',
                  function: isEdit == true
                      ? () {
                          c.onDepartmentType(DepartmentType.ICA);
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: ProvincePage(
                                    isEdit: true,
                                  ),
                                  routeName: PROVINCE_PAGE));
                        }
                      : () {
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnDepartmentType(DepartmentType.ICA));
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: ProvincePage(),
                                  routeName: PROVINCE_PAGE));
                        }),
              CategoryOptions(
                  border: false,
                  wp: wp,
                  option: 'Lambayeque',
                  function: isEdit == true
                      ? () {
                          c.onDepartmentType(DepartmentType.LAMBAYEQUE);
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: ProvincePage(
                                    isEdit: true,
                                  ),
                                  routeName: PROVINCE_PAGE));
                        }
                      : () {
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnDepartmentType(DepartmentType.LAMBAYEQUE));
                          Navigator.push(
                              context,
                              FadeInRoute(
                                  page: ProvincePage(),
                                  routeName: PROVINCE_PAGE));
                        }),
            ],
          ),
        )),
      ),
    );
  }
}
