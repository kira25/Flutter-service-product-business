import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/botton_sheet.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/models/AdminProduct/admin_product.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/product_custom_input.dart';

class StockPage extends StatefulWidget {
  final List<AdminProduct> adminStock;

  const StockPage({this.adminStock});

  // TextEditingController stock = TextEditingController();
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  // loadData() {
  //   BlocProvider.of<ProductsBloc>(context)
  //     ..add(OnAddAdminStock(adminProduct: AdminProduct()));
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   loadData();
  //   print('init data');
  // }

  // List<TextEditingController> _controller = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: kdarkcolor,
            ),
            onPressed: () => Navigator.pop(context)),
        backgroundColor: kprimarycolorlight,
        elevation: 4,
        title: Text(
          'Administrar stock',
          style: GoogleFonts.lato(
              fontSize: wp(4.5),
              color: kdarkcolor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        buildWhen: (previous, current) =>
            previous.adminStock != current.adminStock,
        builder: (context, state) {
          return SafeArea(
            child: _stock(wp, hp, state, context),
          );
        },
      ),
    );
  }

  Container _stock(
      Function wp, Function hp, ProductsState state, BuildContext context) {
    return Container(
      height: hp(90),
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(3)),
      child: Column(
        children: [
          //LIST OF ADMIN STOCKS
          Expanded(
              child: ListView.builder(
            itemExtent: state.stocktype == StockType.BY_SIZE ? hp(80) : hp(45),
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: state.adminStock.length,
            itemBuilder: (_, index) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Color text
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Color ${index + 1}',
                          style: GoogleFonts.lato(
                              fontSize: wp(4),
                              fontWeight: FontWeight.bold,
                              color: kdarkcolor),
                        ),
                        index > 0
                            ? GestureDetector(
                                child: Container(
                                  width: wp(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.trash,
                                        size: wp(3),
                                        color: kwrongAnswer,
                                      ),
                                      Text(
                                        'Eliminar',
                                        style: GoogleFonts.lato(
                                          color: kwrongAnswer,
                                          fontSize: wp(4),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () =>
                                    BlocProvider.of<ProductsBloc>(context)
                                        .add(OnDeleteAdminStock(index)))
                            : Container()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hp(3),
                  ),
                  //STOCK BY SIZE
                  state.stocktype == StockType.BY_SIZE
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: state.adminStock[0].sizeProduct.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                                Container(
                                  height: hp(7),
                                  width: double.infinity,
                                  padding: EdgeInsets.only(
                                      top: 5, bottom: 5, left: 25, right: 20),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                        ),
                                      ],
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          value: state.adminStock[0]
                                                      .sizeProduct[index] !=
                                                  null
                                              ? handleAdminProductSize(state
                                                  .adminStock[0]
                                                  .sizeProduct[index]
                                                  .size)
                                              : 'S',
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('S'),
                                              value: 'S',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('M'),
                                              value: 'M',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('L'),
                                              value: 'L',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('XL'),
                                              value: 'XL',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('XXL'),
                                              value: 'XXL',
                                            ),
                                          ],
                                          onChanged: (value) => BlocProvider.of<
                                                  ProductsBloc>(context)
                                              .add(OnAdminSize(
                                                  handleAdminProductSizeToValue(
                                                      value),
                                                  index)))),
                                ),
                                SizedBox(
                                  height: hp(2),
                                ),
                                //ADMIN BY SIZE : STOCK
                                CustomInput(
                                  hp: hp(8),
                                  placeholder: 'Stock por talla',
                                  keyboardType: TextInputType.phone,
                                  textEditingController: state.adminStock[0]
                                      .sizeProduct[index].sizeStock,
                                  function: (value) =>
                                      BlocProvider.of<ProductsBloc>(context)
                                          .add(
                                              OnAdminBySizeStock(value, index)),
                                )
                              ],
                            ),
                          ),
                        )
                      //STOCK BY COLOR
                      : ProductCustomInput(
                          wp: wp,
                          hp: hp(7),
                          icon: Icons.keyboard_arrow_down,
                          function: () =>
                              displayModalBottomSheetAdminStock(context, index),
                          text: handleAdminColorStock(
                              state.adminStock[index].adminColorType),
                        ),
                  //STOCK TYPE BY COLOR AND SIZE
                  state.stocktype == StockType.BY_COLOR_SIZE
                      ? Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              BlocBuilder<ProductsBloc, ProductsState>(
                                builder: (context, state) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount:
                                          BlocProvider.of<ProductsBloc>(context)
                                              .state
                                              .adminStock[index]
                                              .sizeProduct
                                              .length,
                                      itemBuilder: (_, indexProduct) {
                                        return Container(
                                          height: hp(10),
                                          child: _sizeProduct(state, index,
                                              indexProduct, context, wp, hp),
                                        );
                                      });
                                },
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      color: kintroselected,
                                      icon: Icon(
                                        FontAwesomeIcons.ruler,
                                        size: wp(5),
                                      ),
                                      onPressed: () =>
                                          BlocProvider.of<ProductsBloc>(context)
                                              .add(OnAddSizeProduct(
                                                  index: index,
                                                  sizeProduct: SizeProduct(
                                                      size: Sizes.S)))),
                                  Text(
                                    'Añadir talla',
                                    style: GoogleFonts.lato(
                                        color: kintroselected, fontSize: wp(4)),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : state.stocktype == StockType.BY_SIZE
                          ? Container()
                          : CustomInput(
                              hp: hp(7),
                              placeholder: 'Stock por color',
                              keyboardType: TextInputType.phone,
                              textEditingController:
                                  state.adminStock[index].stock,
                              function: (value) =>
                                  BlocProvider.of<ProductsBloc>(context).add(
                                      OnAdminStock(
                                          state.adminStock[index].stock.text,
                                          index)),
                            ),
                ],
              );
            },
          )),

          MaterialButton(
            height: hp(6),
            color: kprimarycolorlight,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              state.stocktype == StockType.BY_SIZE
                  ? BlocProvider.of<ProductsBloc>(context)
                      .add(OnAddOnlySize(SizeProduct(size: Sizes.S)))
                  : BlocProvider.of<ProductsBloc>(context).add(OnAddAdminStock(
                      adminProduct: AdminProduct(
                          sizeProduct: [SizeProduct(size: Sizes.S)])));
            },
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_box_rounded,
                  color: Colors.blue,
                ),
                Text(state.stocktype == StockType.BY_SIZE
                    ? 'Añadir nueva talla'
                    : ' Añadir nuevo color')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _sizeProduct(ProductsState state, int index, int indexProduct,
      BuildContext context, Function wp, Function hp) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //TALLA
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: state.adminStock[index].sizeProduct[indexProduct]
                                .size !=
                            null
                        ? handleAdminProductSize(state
                            .adminStock[index].sizeProduct[indexProduct].size)
                        : 'Talla',
                    items: [
                      DropdownMenuItem(
                        child: Text('S'),
                        value: 'S',
                      ),
                      DropdownMenuItem(
                        child: Text('M'),
                        value: 'M',
                      ),
                      DropdownMenuItem(
                        child: Text('L'),
                        value: 'L',
                      ),
                      DropdownMenuItem(
                        child: Text('XL'),
                        value: 'XL',
                      ),
                      DropdownMenuItem(
                        child: Text('XXL'),
                        value: 'XXL',
                      ),
                    ],
                    onChanged: (value) => BlocProvider.of<ProductsBloc>(context)
                        .add(OnAdminSizeProduct(
                            index,
                            handleAdminProductSizeToValue(value),
                            indexProduct)))),
          ),
        ),
        SizedBox(
          width: wp(2),
        ),
        Expanded(
          child: CustomInput(
              function: (value) => BlocProvider.of<ProductsBloc>(context)
                  .add(OnAdminSizeProductStock(value, index, indexProduct)),
              hp: hp(7),
              placeholder: 'Stock',
              keyboardType: TextInputType.phone,
              textEditingController:
                  state.adminStock[index].sizeProduct[indexProduct].sizeStock),
        ),
        indexProduct > 0
            ? Container(
                margin: EdgeInsets.only(bottom: 15, left: 15),
                child: CircleAvatar(
                  backgroundColor: kwrongAnswer,
                  radius: wp(4),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: kprimarycolorlight,
                      size: wp(3.5),
                    ),
                    onPressed: () => BlocProvider.of<ProductsBloc>(context)
                        .add(OnDeleteAdminSizeProduct(index, indexProduct)),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
