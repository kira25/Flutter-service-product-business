import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/routes/routes.dart';
import 'package:service_products_business/widgets/category_options.dart';

class CategoryPage extends StatelessWidget {
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
          title: Text('Selecciona categoría',
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
                  option: 'Hogar',
                  function: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(OnSelectCategory(ProductCategory.HOME));
                    Navigator.popAndPushNamed(context, SUBCATEGORY_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Hombre',
                  function: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(OnSelectCategory(ProductCategory.MAN));
                    Navigator.popAndPushNamed(context, SUBCATEGORY_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Infantil',
                  function: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(OnSelectCategory(ProductCategory.KID));
                    Navigator.popAndPushNamed(context, SUBCATEGORY_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Mascotas',
                  function: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(OnSelectCategory(ProductCategory.PET));
                    Navigator.popAndPushNamed(context, SUBCATEGORY_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Mujer',
                  function: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(OnSelectCategory(ProductCategory.WOMEN));
                    Navigator.popAndPushNamed(context, SUBCATEGORY_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Restaurantes',
                  function: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(OnSelectCategory(ProductCategory.RESTAURANT));
                    Navigator.popAndPushNamed(context, SUBCATEGORY_PAGE);
                  }),
              CategoryOptions(
                  wp: wp,
                  option: 'Salud',
                  function: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(OnSelectCategory(ProductCategory.HEALTH));
                    Navigator.popAndPushNamed(context, SUBCATEGORY_PAGE);
                  }),
              CategoryOptions(
                  border: false,
                  wp: wp,
                  option: 'Tecnologia',
                  function: () {
                    BlocProvider.of<ProductsBloc>(context)
                        .add(OnSelectCategory(ProductCategory.TECHNOLOGY));
                    Navigator.popAndPushNamed(context, SUBCATEGORY_PAGE);
                  }),
            ],
          ),
        )),
      ),
    );
  }
}
