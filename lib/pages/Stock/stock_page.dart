import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/botton_sheet.dart';
import 'package:service_products_business/helpers/colors.dart';
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
          buildWhen: (previous, current) =>
              previous.adminStock != current.adminStock,
          builder: (context, state) {
            print('stock page:  ${state.adminStock}');
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
      margin: EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(3)),
      child: Column(
        children: [
          //LIST OF ADMIN STOCKS
          Container(
              height: hp(75),
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
                      ProductCustomInput(
                        wp: wp,
                        hp: hp(7),
                        icon: Icons.keyboard_arrow_down,
                        function: () =>
                            displayModalBottomSheetAdminStock(context, index),
                        text: state.adminStock[index].adminColorType != null
                            ? handleAdminColorStock(
                                state.adminStock[index].adminColorType)
                            : 'Color',
                      ),
                      CustomInput(
                        hp: hp(7),
                        placeholder: 'Stock',
                        keyboardType: TextInputType.phone,
                        textEditingController: state.adminStock[index].stock,
                        function: (value) =>
                            BlocProvider.of<ProductsBloc>(context).add(
                                OnAdminStock(
                                    state.adminStock[index].stock.text, index)),
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
              BlocProvider.of<ProductsBloc>(context)
                  .add(OnAddAdminStock(adminProduct: AdminProduct()));
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
          RaisedButton(
              onPressed: () => BlocProvider.of<ProductsBloc>(context)
                  .add(OnHandleCreateProduct())),
        ],
      ),
    );
  }
}
