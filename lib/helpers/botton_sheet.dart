import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';






void displayModalBottomSheetAdminStock(context, int indexStock) {
  final Function wp = Screen(context).wp;
  final Function hp = Screen(context).hp;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
            ),
            child: Wrap(
              children: <Widget>[
                Material(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 10),
                    height: hp(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.pop(context)),
                            SizedBox(
                              width: wp(30),
                            ),
                            Text(
                              'Color',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: wp(5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        height: hp(42),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            List<Color> color = [
                              kyellowcolor,
                              kintroselected,
                              kintroNotSelected,
                              kdarkcolor,
                              kwrongAnswer,
                              primaryColor
                            ];
                            List namecolors = [
                              'Amarillo',
                              'Azul',
                              'Gris',
                              'Negro',
                              'Rojo',
                              'Rosado'
                            ];
                            List<AdminColorType> colortype = [
                              AdminColorType.YELLOW,
                              AdminColorType.BLUE,
                              AdminColorType.GREY,
                              AdminColorType.BLACK,
                              AdminColorType.RED,
                              AdminColorType.PINK,
                            ];

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 10,
                                      color: color[index],
                                    ),
                                    SizedBox(
                                      width: wp(3),
                                    ),
                                    Text(namecolors[index]),
                                  ],
                                ),
                                BlocBuilder<ProductsBloc, ProductsState>(
                                  builder: (_, state) {
                                    return IconButton(
                                        icon: state.adminStock[indexStock]
                                                    .adminColorType ==
                                                colortype[index]
                                            ? Icon(FontAwesomeIcons.dotCircle)
                                            : Icon(FontAwesomeIcons.circle),
                                        onPressed: () {
                                          print(
                                              'picked color: ${colortype[index]}');
                                          BlocProvider.of<ProductsBloc>(context)
                                              .add(OnAdminColorStock(
                                                  colortype[index],
                                                  indexStock));
                                        });
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      });
}

void displayModalBottomSheetPrice(context) {
  final Function wp = Screen(context).wp;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
            ),
            child: Wrap(
              children: <Widget>[
                Material(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 10),
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () => Navigator.pop(context)),
                            SizedBox(
                              width: wp(22),
                            ),
                            Text(
                              'Nuevo producto',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Normal'),
                              IconButton(
                                  icon: state.priceType == PriceType.NORMAL
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () => BlocProvider.of<
                                          ProductsBloc>(context)
                                      .add(OnPriceTypeChange(PriceType.NORMAL)))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('¡Oferta!'),
                              IconButton(
                                  icon: state.priceType == PriceType.OFFERT
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () => BlocProvider.of<
                                          ProductsBloc>(context)
                                      .add(OnPriceTypeChange(PriceType.OFFERT)))
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ));
      });
}

void displayModalBottomSheetStock(context) {
  final Function wp = Screen(context).wp;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
            ),
            child: Wrap(
              children: <Widget>[
                Material(
                  elevation: 5,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 10),
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () => Navigator.pop(context)),
                            SizedBox(
                              width: wp(22),
                            ),
                            Text(
                              'Stock',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ProductsBloc, ProductsState>(
                  buildWhen: (previous, current) =>
                      previous.stocktype != current.stocktype,
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Unico'),
                              IconButton(
                                  icon: state.stocktype == StockType.UNIQUE
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    BlocProvider.of<ProductsBloc>(context).add(
                                        OnAdminStockType(
                                            AdminStockType.ADMIN_STOCK_UNIQUE));
                                    BlocProvider.of<ProductsBloc>(context)
                                        .add(OnStockType(StockType.UNIQUE));
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Por Color'),
                              IconButton(
                                  icon: state.stocktype == StockType.BY_COLOR
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    BlocProvider.of<ProductsBloc>(context).add(
                                        OnAdminStockType(
                                            AdminStockType.ADMIN_STOCK_COLOR));
                                    BlocProvider.of<ProductsBloc>(context)
                                        .add(OnStockType(StockType.BY_COLOR));
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Por Talla'),
                              IconButton(
                                  icon: state.stocktype == StockType.BY_SIZE
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    BlocProvider.of<ProductsBloc>(context).add(
                                        OnAdminStockType(AdminStockType
                                            .ADMIN_STOCK_BY_SIZE));
                                    BlocProvider.of<ProductsBloc>(context)
                                        .add(OnStockType(StockType.BY_SIZE));
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Por Color y talla'),
                              IconButton(
                                  icon:
                                      state.stocktype == StockType.BY_COLOR_SIZE
                                          ? Icon(FontAwesomeIcons.dotCircle)
                                          : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    BlocProvider.of<ProductsBloc>(context).add(
                                        OnAdminStockType(AdminStockType
                                            .ADMIN_STOCK_BY_COLOR_SIZE));
                                    BlocProvider.of<ProductsBloc>(context).add(
                                        OnStockType(StockType.BY_COLOR_SIZE));
                                  })
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ));
      });
}
