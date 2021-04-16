import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/controller/editproduct_controller.dart';
import 'package:service_products_business/controller/editservices_controller.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/widgets/custom_checkbox.dart';

void displayModalBottomSheetAdminStockToEditProduct(context, int indexStock) {
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

                            return GetX<EditProductController>(
                              init: EditProductController(),
                              builder: (controller) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    IconButton(
                                        icon: controller.adminStock[indexStock]
                                                    .adminColorType ==
                                                colortype[index]
                                            ? Icon(FontAwesomeIcons.dotCircle)
                                            : Icon(FontAwesomeIcons.circle),
                                        onPressed: () =>
                                            controller.onAdminColorStock(
                                                indexStock, colortype[index]))
                                  ],
                                );
                              },
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

//SERVICE PRICE TYPE
void displayModalBottomSheetPriceService(context) {
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
                              'Nuevo servicio',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ServicesBloc, ServicesState>(
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
                                  onPressed: () =>
                                      BlocProvider.of<ServicesBloc>(context)
                                          .add(OnPriceType(PriceType.NORMAL)))
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
                                  onPressed: () =>
                                      BlocProvider.of<ServicesBloc>(context)
                                          .add(OnPriceType(PriceType.OFFERT)))
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

//SERVICE PRICE TY EDIT

void displayModalBottomSheetPriceServiceToEdit(context) {
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
                              'Nuevo servicio',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GetX<EditServicesController>(
                  builder: (state) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Normal'),
                              IconButton(
                                  icon:
                                      state.priceType.value == PriceType.NORMAL
                                          ? Icon(FontAwesomeIcons.dotCircle)
                                          : Icon(FontAwesomeIcons.circle),
                                  onPressed: () =>
                                      state.onPriceType(PriceType.NORMAL))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('¡Oferta!'),
                              IconButton(
                                  icon:
                                      state.priceType.value == PriceType.OFFERT
                                          ? Icon(FontAwesomeIcons.dotCircle)
                                          : Icon(FontAwesomeIcons.circle),
                                  onPressed: () =>
                                      state.onPriceType(PriceType.OFFERT))
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

void displayModalBottomSheetPriceToEditProduct(context) {
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
                GetX<EditProductController>(
                  init: EditProductController(),
                  builder: (controller) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Normal'),
                              IconButton(
                                  icon: controller.priceType.value ==
                                          PriceType.NORMAL
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () =>
                                      controller.setPriceType(PriceType.NORMAL))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('¡Oferta!'),
                              IconButton(
                                  icon: controller.priceType.value ==
                                          PriceType.OFFERT
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () =>
                                      controller.setPriceType(PriceType.OFFERT))
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ));
      });
}

void displayModalBottomSheetStock(context) {
  showModalBottomSheet(
      isDismissible: false,
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
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context)),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Stock',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
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

//UPDATE STOCK AND ADMINSTOCK TYPE

void displayModalBottomSheetToEditProduct(context) {
  showModalBottomSheet(
      isDismissible: false,
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
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context)),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Stock',
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GetX<EditProductController>(
                  init: EditProductController(),
                  builder: (controller) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Unico'),
                              IconButton(
                                  icon: controller.stockType.value ==
                                          StockType.UNIQUE
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    controller.setStockType(StockType.UNIQUE);
                                    controller.setAdminStockType(
                                        AdminStockType.ADMIN_STOCK_UNIQUE);
                                    // BlocProvider.of<ProductsBloc>(context).add(
                                    //     OnAdminStockType(
                                    //         AdminStockType.ADMIN_STOCK_UNIQUE));
                                    // BlocProvider.of<ProductsBloc>(context)
                                    //     .add(OnStockType(StockType.UNIQUE));
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Por Color'),
                              IconButton(
                                  icon: controller.stockType.value ==
                                          StockType.BY_COLOR
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    controller.setStockType(StockType.BY_COLOR);
                                    controller.setAdminStockType(
                                        AdminStockType.ADMIN_STOCK_COLOR);
                                    // BlocProvider.of<ProductsBloc>(context).add(
                                    //     OnAdminStockType(
                                    //         AdminStockType.ADMIN_STOCK_COLOR));
                                    // BlocProvider.of<ProductsBloc>(context)
                                    //     .add(OnStockType(StockType.BY_COLOR));
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Por Talla'),
                              IconButton(
                                  icon: controller.stockType.value ==
                                          StockType.BY_SIZE
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    controller.setStockType(StockType.BY_SIZE);
                                    controller.setAdminStockType(
                                        AdminStockType.ADMIN_STOCK_BY_SIZE);

                                    // BlocProvider.of<ProductsBloc>(context).add(
                                    //     OnAdminStockType(AdminStockType
                                    //         .ADMIN_STOCK_BY_SIZE));
                                    // BlocProvider.of<ProductsBloc>(context)
                                    //     .add(OnStockType(StockType.BY_SIZE));
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Por Color y talla'),
                              IconButton(
                                  icon: controller.stockType.value ==
                                          StockType.BY_COLOR_SIZE
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    controller
                                        .setStockType(StockType.BY_COLOR_SIZE);
                                    controller.setAdminStockType(AdminStockType
                                        .ADMIN_STOCK_BY_COLOR_SIZE);
                                  })
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ));
      });
}
//DISTRICT AVAILABLE EDIT

void displayModalBottomSheetDistrictAvailableToEdit(context) {
  final c = Get.put(EditServicesController());
  final Function wp = Screen(context).wp;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
            ),
            child: ListView(
              shrinkWrap: true,
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
                              width: wp(15),
                            ),
                            Text(
                              'Disponibilidad en distritos',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GetBuilder<EditServicesController>(
                 init: EditServicesController(),
                  builder: (c) {
                    return CustomCheckBox(
                      controller: c,
                      isEdit: true,
                      itemBuilder: (checkBox, label, index) {
                        return Container(
                          child: ListTile(
                            title: label,
                            trailing: checkBox,
                          ),
                        );
                      },
                      wp: wp(35),
                      labels: [
                        DistrictType.ANCON,
                        DistrictType.ATE,
                        DistrictType.BARRANCO,
                        DistrictType.BRENA,
                        DistrictType.CARABAYLLO,
                        DistrictType.COMAS,
                        DistrictType.JESUSMARIA,
                        DistrictType.LIMA,
                        DistrictType.LINCE,
                        DistrictType.LURIGANCHO,
                        DistrictType.MOLINA,
                        DistrictType.OLIVOS,
                        DistrictType.SANBORJA,
                        DistrictType.SANISIDRO,
                        DistrictType.SURCO,
                        DistrictType.SURQUILLO
                      ],
                      onSelected: (selected) => c.onDistrictAvailable(selected),
                    );
                  },
                ),
                MaterialButton(
                    child: Text('Limpiar seleccion'),
                    onPressed: () => c.onDistrictAvailable([]))
              ],
            ));
      });
}

void displayModalBottomSheetDistrictAvailable(context) {
  final Function wp = Screen(context).wp;
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 4.0 * 3.0,
            ),
            child: ListView(
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
                              width: wp(15),
                            ),
                            Text(
                              'Disponibilidad en distritos',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ServicesBloc, ServicesState>(
                  buildWhen: (previous, current) =>
                      previous.districtAvailable != current.districtAvailable,
                  builder: (context, state) {
                    return CustomCheckBox(
                      state: state,
                      itemBuilder: (checkBox, label, index) {
                        return Container(
                          child: ListTile(
                            title: label,
                            trailing: checkBox,
                          ),
                        );
                      },
                      wp: wp(35),
                      labels: [
                        DistrictType.ANCON,
                        DistrictType.ATE,
                        DistrictType.BARRANCO,
                        DistrictType.BRENA,
                        DistrictType.CARABAYLLO,
                        DistrictType.COMAS,
                        DistrictType.JESUSMARIA,
                        DistrictType.LIMA,
                        DistrictType.LINCE,
                        DistrictType.LURIGANCHO,
                        DistrictType.MOLINA,
                        DistrictType.OLIVOS,
                        DistrictType.SANBORJA,
                        DistrictType.SANISIDRO,
                        DistrictType.SURCO,
                        DistrictType.SURQUILLO
                      ],
                      onSelected: (selected) =>
                          BlocProvider.of<ServicesBloc>(context)
                              .add(OnDistrictAvailable(selected)),
                    );
                  },
                ),
                MaterialButton(
                    child: Text('Limpiar seleccion'),
                    onPressed: () => BlocProvider.of<ServicesBloc>(context)
                        .add(OnDistrictAvailable([])))
              ],
            ));
      });
}

void displayModalBottomSheetAvailableType(context) {
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
                              'Disponibilidad',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ServicesBloc, ServicesState>(
                  buildWhen: (previous, current) =>
                      previous.availableType != current.availableType,
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('En tienda'),
                              IconButton(
                                  icon:
                                      state.availableType == AvailableType.SHOP
                                          ? Icon(FontAwesomeIcons.dotCircle)
                                          : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    BlocProvider.of<ServicesBloc>(context).add(
                                        OnAvailableType(AvailableType.SHOP));
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('A domicilio'),
                              IconButton(
                                  icon:
                                      state.availableType == AvailableType.HOME
                                          ? Icon(FontAwesomeIcons.dotCircle)
                                          : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    BlocProvider.of<ServicesBloc>(context).add(
                                        OnAvailableType(AvailableType.HOME));
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tienda / Domicilio'),
                              IconButton(
                                  icon: state.availableType ==
                                          AvailableType.SHOP_HOME
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () {
                                    BlocProvider.of<ServicesBloc>(context).add(
                                        OnAvailableType(
                                            AvailableType.SHOP_HOME));
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

void displayModalBottomSheetAvailableTypeToEdit(context) {
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
                              'Disponibilidad',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GetX<EditServicesController>(
                  builder: (state) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('En tienda'),
                              IconButton(
                                  icon: state.availableType.value ==
                                          AvailableType.SHOP
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () =>
                                      state.onAvailableType(AvailableType.SHOP))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('A domicilio'),
                              IconButton(
                                  icon: state.availableType.value ==
                                          AvailableType.HOME
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () =>
                                      state.onAvailableType(AvailableType.HOME))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tienda / Domicilio'),
                              IconButton(
                                  icon: state.availableType.value ==
                                          AvailableType.SHOP_HOME
                                      ? Icon(FontAwesomeIcons.dotCircle)
                                      : Icon(FontAwesomeIcons.circle),
                                  onPressed: () => state
                                      .onAvailableType(AvailableType.SHOP_HOME))
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
