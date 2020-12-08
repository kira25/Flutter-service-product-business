import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/auth/auth_bloc.dart';
import 'package:service_products_business/bloc/orders_products/orders_products_bloc.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/bloc/shop/shop_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/helpers/products.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/models/product_response.dart';
import 'package:service_products_business/pages/AddProducts/add_products_page.dart';
import 'package:service_products_business/pages/Login/login_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TabController tabController;

  // loadData() {
  //   setState(() {
  //     BlocProvider.of<ShopBloc>(context)..add(OnLoadShopData());
  //   });
  // }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (BuildContext context, state) {
        return BlocProvider<ShopBloc>(
          create: (context) => ShopBloc()..add(OnLoadShopData()),
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                onTap: (value) {
                  BlocProvider.of<ShopBloc>(context)
                      .add(OnTabIndexChange(value));
                  // if (BlocProvider.of<ShopBloc>(context).state.tabindex == 1) {
                  //   BlocProvider.of<ProductsBloc>(context)
                  //       .add(OnLoadShopProducts());
                  // }
                },
                elevation: 4,
                showUnselectedLabels: true,
                unselectedLabelStyle:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 12),
                selectedLabelStyle:
                    GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 12),
                selectedItemColor: Colors.blue,
                unselectedItemColor: Colors.grey[400],
                backgroundColor: Theme.of(context).primaryColor,
                currentIndex: BlocProvider.of<ShopBloc>(context).state.tabindex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.listUl),
                    label: 'Ordenes',
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.cube), label: 'Productos'),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.layerGroup),
                      label: 'Servicios'),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.user), label: 'Mi cuenta'),
                ]),
            body: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (!state.authenticated) {
                  CustomRouteTransition(context: context, child: LoginPage());
                }
              },
              child: IndexedStack(
                index: BlocProvider.of<ShopBloc>(context).state.tabindex,
                children: [
                  _orders(hp, wp),
                  //PRODUCTS
                  _products(hp, wp),
                  //SERVICES
                  _services(hp, wp),
                  //USER
                  _user(hp, wp),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Scaffold _orders(Function hp, Function wp) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimarycolorlight,
        title: Text('Ordenes',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, color: Colors.black)),
        bottom: TabBar(
            physics: BouncingScrollPhysics(),
            indicatorColor: kintroselected,
            controller: tabController,
            tabs: [
              Tab(
                child: Text(
                  'Productos',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, color: kintroselected),
                ),
              ),
              Tab(
                child: Text(
                  'Servicios',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, color: kintroselected),
                ),
              ),
            ]),
      ),
      body: SafeArea(
          child: Container(
              child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(top: 10, left: 10),
                    width: double.infinity,
                    child: ListView.separated(
                      padding: EdgeInsets.all(5),
                      itemCount: 4,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        List list = [
                          'Pendientes',
                          'Seguimiento',
                          'Completados',
                          'Rechazados'
                        ];
                        return MaterialButton(
                          key: Key(index.toString()),
                          onPressed: () {
                            switch (index) {
                              case 0:
                                BlocProvider.of<OrdersProductsBloc>(context)
                                    .add(OnProductPending());

                                break;
                              case 1:
                                BlocProvider.of<OrdersProductsBloc>(context)
                                    .add(OnProductFollowing());
                                break;
                              case 2:
                                BlocProvider.of<OrdersProductsBloc>(context)
                                    .add(OnProductCompleted());
                                break;
                              case 3:
                                BlocProvider.of<OrdersProductsBloc>(context)
                                    .add(OnProductRejected());
                                break;

                              default:
                            }
                          },
                          color: Colors.blue[200],
                          child: Text(list[index],
                              style: GoogleFonts.lato(
                                fontSize: wp(4),
                              )),
                          shape: StadiumBorder(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        indent: 10,
                      ),
                    ),
                  ),
                  BlocBuilder<OrdersProductsBloc, OrdersProductsState>(
                    builder: (context, state) {
                      if (state.showPending) {
                        return OrdersProducts(
                          hp: hp,
                          title: 'No tienes solicitudes de pedidos',
                          subtitle: 'Administra los pedidos de tus clientes',
                        );
                      } else if (state.showFollowing) {
                        return OrdersProducts(
                          hp: hp,
                          title: 'No tienes pedidos en proceso de envio',
                          subtitle: 'Realiza el seguimiento de tu pedido',
                        );
                      } else if (state.showCompleted) {
                        return OrdersProducts(
                          hp: hp,
                          title: 'No tienes pedidos completados',
                          subtitle: 'Verifica tus pedidos entregados',
                        );
                      } else if (state.showRejected) {
                        return OrdersProducts(
                          hp: hp,
                          title: 'No tienes pedidos rechazados',
                          subtitle: 'Verifica tus pedidos rechazados',
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Icon(Icons.meeting_room),
                ],
              ),
            ),
          ]))),
    );
  }

  Widget _user(Function hp, Function wp) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[primaryColor, secondaryColor],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Scaffold(
      appBar: AppBar(
          actions: [
            Container(
              height: hp(12),
              width: wp(25),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Kallpa',
                      style: GoogleFonts.oswald(
                          textStyle: new TextStyle(
                              fontSize: wp(5),
                              foreground: Paint()..shader = linearGradient)),
                    ),
                  ),
                  Positioned(
                    bottom: hp(1),
                    right: 16,
                    child: Text(
                      'Business',
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                              foreground: Paint()..shader = linearGradient,
                              letterSpacing: 1.0,
                              fontSize: wp(3))),
                    ),
                  ),
                ],
              ),
            )
          ],
          backgroundColor: kprimarycolorlight,
          title: Text(
            'Mi cuenta',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, color: Colors.black),
          )),
      body: SafeArea(child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return Container(
            child: _userShopOptions(wp, hp, state),
          );
        },
      )),
    );
  }

  Column _userShopOptions(Function wp, Function hp, ShopState state) {
    return Column(
      children: [
        //USERS INFO
        state.shopResponse == null
            ? CircularProgressIndicator()
            : Container(
                margin:
                    EdgeInsets.symmetric(horizontal: wp(6), vertical: hp(3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: wp(7),
                          backgroundImage: Image.network(
                                  state.shopResponse.shop.profilePhoto)
                              .image,
                        ),
                        SizedBox(
                          width: wp(3),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.shopResponse.shop.title,
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold, fontSize: wp(5)),
                            ),
                            Text(state.shopResponse.shop.email,
                                style: GoogleFonts.lato(
                                    color: kintroNotSelected, fontSize: wp(4)))
                          ],
                        ),
                      ],
                    ),
                    //0xFF81CCEE
                    IconButton(
                        icon: CircleAvatar(
                          radius: wp(3),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: kprimarycolorlight,
                            size: wp(2.5),
                          ),
                        ),
                        onPressed: () {
                          print('my account');
                        })
                  ],
                ),
              ),
        //REVENUE
        UserOptions(
          hp: hp,
          wp: wp,
          iconData: FontAwesomeIcons.shoppingBag,
          title: 'Mis ganancias',
          subTitle: 'Revisa el detalle de tus ganancias generales',
        ),
        //ACCOUNT BANK
        UserOptions(
          hp: hp,
          wp: wp,
          iconData: FontAwesomeIcons.creditCard,
          title: 'Mis cuentas bancarias',
          subTitle: 'Administra tus cuentas bancarias',
        ),
        //Terms and conditions
        UserOptions(
          hp: hp,
          wp: wp,
          iconData: FontAwesomeIcons.calendarCheck,
          title: 'Terminos y condiciones',
          subTitle: 'Información legal de Kallpa Business',
        ),
        // Contact kallpa business
        UserOptions(
          hp: hp,
          wp: wp,
          iconData: FontAwesomeIcons.whatsapp,
          title: 'Contactate con Kallpa Business',
          subTitle: '¿Tienes alguna consulta o queja? Contactanos',
        )
        // Log out
        ,
        UserOptions(
          onPressed: () =>
              BlocProvider.of<AuthBloc>(context).add(AuthenticationLogout()),
          hp: hp,
          wp: wp,
          iconData: FontAwesomeIcons.signOutAlt,
          title: 'Cerrar sesión',
          subTitle: 'Cierra sesion de tu cuenta Kallpa Business',
        )
      ],
    );
  }

  Scaffold _services(Function hp, Function wp) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          heroTag: 'btn_services',
          child: Icon(
            Icons.add,
            size: 35,
          ),
          onPressed: () {}),
      appBar: AppBar(
          elevation: 4,
          backgroundColor: kprimarycolorlight,
          title: Text(
            'Servicios',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, color: Colors.black),
          )),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.layerGroup,
                      size: 45, color: Colors.purple),
                  SizedBox(
                    height: hp(3),
                  ),
                  Text(
                    'No tienes servicios',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: hp(3),
                  ),
                  Text('Añade un servicio para empezar a ofrecer ',
                      style: GoogleFonts.lato(fontSize: 15)),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget _products(Function hp, Function wp) {
    return BlocProvider<ProductsBloc>(
      lazy: false,
      create: (context) => ProductsBloc()..add(OnLoadShopProducts()),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
                heroTag: 'btn_products',
                child: Icon(
                  Icons.add,
                  size: 35,
                ),
                onPressed: () {
                  CustomRouteTransition(context: context, child: AddProducts());
                }),
            appBar: AppBar(
                elevation: 4,
                backgroundColor: kprimarycolorlight,
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(hp(8)),
                    child: Container(
                      height: hp(7),
                      child: _productOptions(wp, hp, state),
                    )),
                title: Text(
                  'Productos',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
            body: SafeArea(
                child: Container(
              width: double.infinity,
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  //PRODUCTS CATEGORY
                  if (state.showProducts == ProductCategory.HOME) {
                    return ItemsCategoryProduct(
                        state: state,
                        productCategory: ProductCategory.HOME,
                        hp: hp,
                        wp: wp);
                  }
                  if (state.showProducts == ProductCategory.MAN) {
                    return ItemsCategoryProduct(
                        state: state,
                        productCategory: ProductCategory.MAN,
                        hp: hp,
                        wp: wp);
                  }
                  if (state.showProducts == ProductCategory.KID) {
                    return ItemsCategoryProduct(
                        state: state,
                        productCategory: ProductCategory.KID,
                        hp: hp,
                        wp: wp);
                  }
                  if (state.showProducts == ProductCategory.PET) {
                    return ItemsCategoryProduct(
                        state: state,
                        productCategory: ProductCategory.PET,
                        hp: hp,
                        wp: wp);
                  }
                  if (state.showProducts == ProductCategory.WOMEN) {
                    return ItemsCategoryProduct(
                        state: state,
                        productCategory: ProductCategory.WOMEN,
                        hp: hp,
                        wp: wp);
                  }
                  if (state.showProducts == ProductCategory.RESTAURANT) {
                    return ItemsCategoryProduct(
                        state: state,
                        productCategory: ProductCategory.RESTAURANT,
                        hp: hp,
                        wp: wp);
                  }
                  if (state.showProducts == ProductCategory.HEALTH) {
                    return ItemsCategoryProduct(
                        state: state,
                        productCategory: ProductCategory.HEALTH,
                        hp: hp,
                        wp: wp);
                  }
                  if (state.showProducts == ProductCategory.TECHNOLOGY) {
                    return ItemsCategoryProduct(
                        state: state,
                        productCategory: ProductCategory.TECHNOLOGY,
                        hp: hp,
                        wp: wp);
                  }
                  if (state.productResponse == null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.cube,
                                  size: 45, color: Colors.purple),
                              SizedBox(
                                height: hp(3),
                              ),
                              Text(
                                'No tienes productos',
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    fontSize: wp(6)),
                              ),
                              SizedBox(
                                height: hp(3),
                              ),
                              Text('Añade un producto para empezar a vender',
                                  style: GoogleFonts.lato(fontSize: wp(4))),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                },
              ),
            )),
          );
        },
      ),
    );
  }

  Widget _productOptions(Function wp, Function hp, ProductsState state) {
    List list = [
      'Casa',
      'Hombre',
      'Niños',
      'Mascotas',
      'Mujer',
      'Restaurante',
      'Salud',
      'Tecnologia'
    ];
    return ListView.separated(
      itemCount: list.length,
      padding: EdgeInsets.only(left: wp(6), bottom: hp(2)),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return MaterialButton(
          key: Key(''),
          onPressed: () {
            switch (index) {
              case 0:
                BlocProvider.of<ProductsBloc>(context)
                    .add(OnShowProducts(ProductCategory.HOME));

                break;
              case 1:
                BlocProvider.of<ProductsBloc>(context)
                    .add(OnShowProducts(ProductCategory.MAN));

                break;
              case 2:
                BlocProvider.of<ProductsBloc>(context)
                    .add(OnShowProducts(ProductCategory.KID));

                break;
                case 3:
                BlocProvider.of<ProductsBloc>(context)
                    .add(OnShowProducts(ProductCategory.PET));

                break;
                case 4:
                BlocProvider.of<ProductsBloc>(context)
                    .add(OnShowProducts(ProductCategory.WOMEN));

                break;
                case 5:
                BlocProvider.of<ProductsBloc>(context)
                    .add(OnShowProducts(ProductCategory.RESTAURANT));

                break;
                case 6:
                BlocProvider.of<ProductsBloc>(context)
                    .add(OnShowProducts(ProductCategory.HEALTH));

                break;
                case 7:
                BlocProvider.of<ProductsBloc>(context)
                    .add(OnShowProducts(ProductCategory.TECHNOLOGY));

                break;
              default:
            }
          },
          color: Colors.blue[200],
          child: Text(list[index],
              style: GoogleFonts.lato(
                fontSize: wp(4),
              )),
          shape: StadiumBorder(),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        indent: 10,
      ),
    );
  }
}

class ItemsCategoryProduct extends StatelessWidget {
  final Function hp;
  final Function wp;
  final ProductsState state;
  final ProductCategory productCategory;
  const ItemsCategoryProduct({
    Key key,
    this.hp,
    this.wp,
    this.state,
    this.productCategory,
  });

  @override
  Widget build(BuildContext context) {
    List<Product> result = state.productResponse.product
        .where((element) =>
            element.productCategory.category == productCategory.index)
        .toList();
    return Container(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              height: hp(25),
              child: Card(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    //IMAGE PRODUCT
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: wp(4), vertical: hp(1)),
                      width: wp(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          result[index].imageProduct.isEmpty
                              ? Container()
                              : Image.network(
                                  result[index].imageProduct[0].product,
                                  height: hp(15),
                                ),
                        ],
                      ),
                    ),
                    //PRODUCT DATA
                    Container(
                      width: wp(55),
                      padding: EdgeInsets.symmetric(vertical: hp(1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            result[index].name,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold, fontSize: wp(4.5)),
                          ),
                          result[index].price.offertPrice != null
                              ? Text(
                                  'Precio Oferta : S/ ${result[index].price.offertPrice}',
                                  style: GoogleFonts.lato(fontSize: wp(3.5)),
                                )
                              : Text(
                                  'Precio Normal : S/ ${result[index].price.normalPrice}',
                                  style: GoogleFonts.lato(fontSize: wp(3.5)),
                                ),
                          RichText(
                            text: TextSpan(
                                text: 'Stock ',
                                style: GoogleFonts.lato(
                                    textStyle:
                                        TextStyle(color: kintroNotSelected),
                                    fontSize: wp(3.5)),
                                children: [
                                  result[index].amountStock != 0
                                      ? TextSpan(
                                          text: 'Disponible',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: kstockAvailable)))
                                      : TextSpan(
                                          text:
                                              'Algunas tallas o colores sin stock',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: kwrongAnswer)))
                                ]),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: kintroselected,
                                borderRadius: BorderRadius.circular(20)),
                            height: hp(3),
                            width: wp(25),
                            child: Center(
                              child: Text(
                                handleProductCategoryFromResponse(
                                    result[index].productCategory.subcategory),
                                style: GoogleFonts.lato(
                                    color: kprimarycolorlight, fontSize: wp(4)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 10,
              ),
          itemCount: result.length),
    );
  }
}

class OrdersProducts extends StatelessWidget {
  final Function hp;
  final String title;
  final String subtitle;
  const OrdersProducts({
    this.hp,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesomeIcons.listUl, size: 45, color: Colors.purple),
          SizedBox(
            height: hp(3),
          ),
          Text(
            title,
            style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: hp(3),
          ),
          Text(subtitle, style: GoogleFonts.lato(fontSize: 15)),
        ],
      ),
    );
  }
}

class UserOptions extends StatelessWidget {
  final Function hp;
  final Function wp;
  final String title;
  final String subTitle;
  final IconData iconData;
  final Function onPressed;
  const UserOptions(
      {this.hp,
      this.wp,
      this.title,
      this.subTitle,
      this.iconData,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: kintroNotSelected, width: 1))),
      margin: EdgeInsets.symmetric(horizontal: wp(6), vertical: hp(1)),
      padding: EdgeInsets.only(bottom: hp(1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconData),
              SizedBox(
                width: wp(3),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold, fontSize: wp(4)),
                  ),
                  Text(subTitle,
                      style: GoogleFonts.lato(
                          color: kintroNotSelected, fontSize: wp(3)))
                ],
              ),
            ],
          ),
          IconButton(
              icon: CircleAvatar(
                backgroundColor: kintroNotSelected,
                radius: wp(3),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: wp(2.5),
                  color: kprimarycolorlight,
                ),
              ),
              onPressed: onPressed)
        ],
      ),
    );
  }
}