import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/widgets/category_options.dart';

class SubcategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimarycolorlight,
        title: Text('Selecciona subcategoría',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, color: kdarkcolor)),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: kdarkcolor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
          child: Container(
        height: hp(90),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          children: [
            CategoryOptions(
                wp: wp,
                option: 'Baño',
                function: () {
                  BlocProvider.of<ProductsBloc>(context)
                      .add(OnSelectSubcategory(ProductSubCategory.BATHROOM));
                  Navigator.pop(context);
                }),
            CategoryOptions(
                wp: wp,
                option: 'Cocina',
                function: () {
                  BlocProvider.of<ProductsBloc>(context)
                      .add(OnSelectSubcategory(ProductSubCategory.KITCHEN));
                  Navigator.pop(context);
                }),
            CategoryOptions(
                wp: wp,
                option: 'Decoración',
                function: () {
                  BlocProvider.of<ProductsBloc>(context)
                      .add(OnSelectSubcategory(ProductSubCategory.DECORATION));
                  Navigator.pop(context);
                }),
            CategoryOptions(
                wp: wp,
                option: 'Electrohogar',
                function: () {
                  BlocProvider.of<ProductsBloc>(context).add(
                      OnSelectSubcategory(ProductSubCategory.ELECTRONIC_HOME));
                  Navigator.pop(context);
                }),
            CategoryOptions(
                wp: wp,
                option: 'Mujer',
                function: () {
                  BlocProvider.of<ProductsBloc>(context)
                      .add(OnSelectSubcategory(ProductSubCategory.WOMEN));
                  Navigator.pop(context);
                }),
            CategoryOptions(
                wp: wp,
                option: 'Muebles',
                function: () {
                  BlocProvider.of<ProductsBloc>(context)
                      .add(OnSelectSubcategory(ProductSubCategory.FURNITURE));
                  Navigator.pop(context);
                }),
            CategoryOptions(
                border: false,
                wp: wp,
                option: 'Plantas',
                function: () {
                  BlocProvider.of<ProductsBloc>(context)
                      .add(OnSelectSubcategory(ProductSubCategory.PLANT));
                  Navigator.pop(context);
                }),
          ],
        ),
      )),
    );
  }
}
