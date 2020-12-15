import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/routes/routes.dart';
import 'package:service_products_business/widgets/category_options.dart';

class DepartmentPage extends StatelessWidget {
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
                  function: () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDepartmentType(DepartmentType.LIMA));
                    Navigator.popAndPushNamed(context, PROVINCE_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Arequipa',
                  function: () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDepartmentType(DepartmentType.AREQUIPA));
                    Navigator.popAndPushNamed(context, PROVINCE_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Ica',
                  function: () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDepartmentType(DepartmentType.ICA));
                    Navigator.popAndPushNamed(context, PROVINCE_PAGE);
                  }),
              CategoryOptions(
                  border: false,
                  wp: wp,
                  option: 'Lambayeque',
                  function: () {
                    BlocProvider.of<ServicesBloc>(context)
                        .add(OnDepartmentType(DepartmentType.LAMBAYEQUE));
                    Navigator.popAndPushNamed(context, PROVINCE_PAGE);
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
