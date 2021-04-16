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
import 'package:service_products_business/routes/routes.dart';
import 'package:service_products_business/widgets/category_options.dart';

class DistrictPage extends StatelessWidget {
  final c = Get.put(EditServicesController());

  final bool isEdit;

  DistrictPage({this.isEdit});

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
          title: Text('Selecciona distrito',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, color: kdarkcolor))),
      body: WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                CategoryOptions(
                    wp: wp,
                    option: 'Jesus Maria',
                    function: isEdit == true
                        ? () {
                            c.onDistrictType(DistrictType.JESUSMARIA);

                            CustomNavigatorPop(
                                context: context, popPage: EDIT_SERVICES_PAGE);
                          }
                        : () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(OnDistrictType(DistrictType.JESUSMARIA));
                            CustomNavigatorPop(
                                context: context, popPage: ADD_SERVICES_PAGE);
                          }),
                CategoryOptions(
                    wp: wp,
                    option: 'Lince',
                    function: isEdit == true
                        ? () {
                            c.onDistrictType(DistrictType.LINCE);
                            CustomNavigatorPop(
                                context: context, popPage: EDIT_SERVICES_PAGE);
                          }
                        : () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(OnDistrictType(DistrictType.LINCE));
                            CustomNavigatorPop(
                                context: context, popPage: ADD_SERVICES_PAGE);
                          }),
                CategoryOptions(
                    wp: wp,
                    option: 'La Molina',
                    function: isEdit == true
                        ? () {
                            c.onDistrictType(DistrictType.MOLINA);
                            CustomNavigatorPop(
                                context: context, popPage: EDIT_SERVICES_PAGE);
                          }
                        : () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(OnDistrictType(DistrictType.MOLINA));
                            CustomNavigatorPop(
                                context: context, popPage: ADD_SERVICES_PAGE);
                          }),
                CategoryOptions(
                    wp: wp,
                    option: 'San Borja',
                    function: isEdit == true
                        ? () {
                            c.onDistrictType(DistrictType.SANBORJA);
                            CustomNavigatorPop(
                                context: context, popPage: EDIT_SERVICES_PAGE);
                          }
                        : () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(OnDistrictType(DistrictType.SANBORJA));
                            CustomNavigatorPop(
                                context: context, popPage: ADD_SERVICES_PAGE);
                          }),
                CategoryOptions(
                    wp: wp,
                    option: 'San Isidro',
                    function: isEdit == true
                        ? () {
                            c.onDistrictType(DistrictType.SANISIDRO);
                            CustomNavigatorPop(
                                context: context, popPage: EDIT_SERVICES_PAGE);
                          }
                        : () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(OnDistrictType(DistrictType.SANISIDRO));
                            CustomNavigatorPop(
                                context: context, popPage: ADD_SERVICES_PAGE);
                          }),
                CategoryOptions(
                    wp: wp,
                    option: 'Surco',
                    function: isEdit == true
                        ? () {
                            c.onDistrictType(DistrictType.SURCO);
                            CustomNavigatorPop(
                                context: context, popPage: EDIT_SERVICES_PAGE);
                          }
                        : () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(OnDistrictType(DistrictType.SURCO));
                            CustomNavigatorPop(
                                context: context, popPage: ADD_SERVICES_PAGE);
                          }),
                CategoryOptions(
                    border: false,
                    wp: wp,
                    option: 'Surquillo',
                    function: isEdit == true
                        ? () {
                            c.onDistrictType(DistrictType.SURQUILLO);
                            CustomNavigatorPop(
                                context: context, popPage: EDIT_SERVICES_PAGE);
                          }
                        : () {
                            BlocProvider.of<ServicesBloc>(context)
                                .add(OnDistrictType(DistrictType.SURQUILLO));
                            CustomNavigatorPop(
                              context: context,
                              popPage: PROVINCE_PAGE,
                            );
                          }),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
