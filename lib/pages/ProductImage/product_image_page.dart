import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/widgets/custom_fab.dart';

class ProductImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        wp: wp,
        text: 'Crear producto',
        onPressed: () =>
            BlocProvider.of<ProductsBloc>(context).add(OnHandleCreateProduct()),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
            child: BlocListener<ProductsBloc, ProductsState>(
          listenWhen: (previous, current) =>
              previous.isProductCreated != current.isProductCreated,
          listener: (_, state) {
            if (state.isProductCreated == IsProductCreated.SUCCESS) {
              showAlert(context,
                  title: 'Producto creado con exito',
                  subtitle: 'Aceptar',
                  child: MainPage());
              BlocProvider.of<ProductsBloc>(context).add(OnCleanProductData());
            } else if (state.isProductCreated == IsProductCreated.FAIL) {
              showDialog(
                  context: _,
                  builder: (_) => new AlertDialog(
                        title: new Text("Product already exist"),
                      ));
            } else if (state.isProductCreated == IsProductCreated.LOADING) {
              showDialog(
                  context: _,
                  builder: (_) => new AlertDialog(
                        title: new Text("Creating product..."),
                      ));
            }
          },
          child: Container(
            child: Column(
              children: [
                _header(context),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    return _imageProducts(hp, wp, context, state);
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Container _imageProducts(
      Function hp, Function wp, BuildContext context, ProductsState state) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      height: hp(76),
      child: Column(
        children: [
          Text(
            'Fotos del producto(Max. 5)',
            style: GoogleFonts.lato(color: kdarkcolor, fontSize: wp(4)),
          ),
          SizedBox(
            height: hp(3),
          ),
          state.productImage.isNotEmpty
              ? Container(
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            height: hp(3),
                            color: kprimarycolorlight,
                          ),
                      shrinkWrap: true,
                      itemCount: state.productImage.length,
                      itemBuilder: (context, index) {
                        return MaterialButton(
                          height: hp(8),
                          color: kprimarycolorlight,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () => print(''),
                          elevation: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                  radius: wp(5),
                                  backgroundImage: Image.file(File(
                                          state.productImage[index]["product"]))
                                      .image),
                              Text(
                                '${state.productImage[index]["product"].split('/').last}',
                                style: GoogleFonts.lato(fontSize: 10),
                              ),
                              CircleAvatar(
                                backgroundColor: kwrongAnswer,
                                radius: wp(4),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: kprimarycolorlight,
                                    size: wp(3.5),
                                  ),
                                  onPressed: () =>
                                      BlocProvider.of<ProductsBloc>(context)
                                          .add(OnDeleteProductImage(index)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              : Container(),
          SizedBox(
            height: hp(3),
          ),
          MaterialButton(
            height: hp(6),
            color: kprimarycolorlight,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () => state.productImage.length > 4
                ? null
                : BlocProvider.of<ProductsBloc>(context)
                    .add(OnAddProductImage()),
            elevation: 3,
            child: Row(
              children: [
                Icon(
                  Icons.add_box_rounded,
                  color: Colors.blue,
                ),
                Text(' Añadir foto(s)')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
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
                    onPressed: () => Navigator.pop(context)),
                Text(
                  'Nuevo producto',
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
                '2/2',
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
