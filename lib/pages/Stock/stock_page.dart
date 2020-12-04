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
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/models/AdminProduct/admin_product.dart';
import 'package:service_products_business/pages/AddProducts/add_products_page.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/product_custom_input.dart';

class StockPage extends StatefulWidget {
  // TextEditingController stock = TextEditingController();
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  // loadData() {
  //   BlocProvider.of<ProductsBloc>(context)
  //     ..add(OnAddAdminStock(adminProduct: AdminProduct()));
  // }

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
    ProductsBloc productsBloc = BlocProvider.of<ProductsBloc>(context);
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: kdarkcolor,
            ),
            onPressed: () =>
                CustomRouteTransition(context: context, child: AddProducts())),
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
      body: SingleChildScrollView(
        child: BlocBuilder<ProductsBloc, ProductsState>(
          // buildWhen: (previous, current) =>
          //     previous.adminStock != current.adminStock,
          builder: (context, state) {
           print(state.category);
           print(state.subCategory);
            return SafeArea(
              child: _stock(wp, hp, state, context),
            );
          },
        ),
      ),
    );
  }

  Container _stock(
      Function wp, Function hp, ProductsState state, BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(3)),
      child: Column(
        children: [
          //LIST OF ADMIN STOCKS
          Container(
              height: hp(75),
              width: double.infinity,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: state.adminStock.length,
                itemBuilder: (_, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      state.stocktype == StockType.BY_SIZE
                          ? Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 20),
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
                                      value:
                                          state.adminStock[index].size != null
                                              ? handleAdminProductSize(
                                                  state.adminStock[index].size)
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
                                      onChanged: (value) =>
                                          BlocProvider.of<ProductsBloc>(context)
                                              .add(OnAdminSize(
                                                  handleAdminProductSizeToValue(
                                                      value),
                                                  index)))),
                            )
                          : ProductCustomInput(
                              wp: wp,
                              hp: hp(7),
                              icon: Icons.keyboard_arrow_down,
                              function: () => displayModalBottomSheetAdminStock(
                                  context, index),
                              text: handleAdminColorStock(
                                  state.adminStock[index].adminColorType),
                            ),
                      //STOCK TYPE BY COLOR AND SIZE
                      state.stocktype == StockType.BY_COLOR_SIZE
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                BlocBuilder<ProductsBloc, ProductsState>(
                                  builder: (context, state) {
                                    return Container(
                                      height: hp(10),
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount:
                                              BlocProvider.of<ProductsBloc>(
                                                      context)
                                                  .state
                                                  .adminStock[index]
                                                  .sizeProduct
                                                  .length,
                                          itemBuilder: (_, indexProduct) {
                                            return Container(
                                              height: hp(10),
                                              child: _sizeProduct(
                                                  state,
                                                  index,
                                                  indexProduct,
                                                  context,
                                                  wp,
                                                  hp),
                                            );
                                          }),
                                    );
                                  },
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        color: kintroselected,
                                        icon: Icon(
                                          FontAwesomeIcons.ruler,
                                          size: wp(5),
                                        ),
                                        onPressed: () =>
                                            BlocProvider.of<ProductsBloc>(
                                                    context)
                                                .add(OnAddSizeProduct(
                                                    index: index,
                                                    sizeProduct: SizeProduct(
                                                        size: Size.S)))),
                                    Text(
                                      'Añadir talla',
                                      style: GoogleFonts.lato(
                                          color: kintroselected,
                                          fontSize: wp(4)),
                                    )
                                  ],
                                )
                              ],
                            )
                          : CustomInput(
                              hp: hp(7),
                              placeholder: 'Stock',
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
              BlocProvider.of<ProductsBloc>(context).add(OnAddAdminStock(
                  adminProduct:
                      AdminProduct(sizeProduct: [SizeProduct(size: Size.S)])));
            }
            //TODO: change to manage with Bloc
            // setState(() {
            //   names.add('Color ${names.length}');
            //   _controller.add(TextEditingController());
            // });
            ,
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_box_rounded,
                  color: Colors.blue,
                ),
                Text(' Añadir nuevo color')
              ],
            ),
          ),
          RaisedButton(onPressed: () {
            // List list = state.adminStock.map((e) => e.toJsonSizeProduct()).toList();
            // print(state.adminStock[0].sizeProduct[0].size);
            // print(state.adminStock[0].sizeProduct[0].sizeStock.text);
            // print(state.adminStock[0].toJson());
            // print(state.adminStock[0].toJsonSize());
            // print(state.adminStock[0].toJsonSizeProduct());
            // print(list);
          }),
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
