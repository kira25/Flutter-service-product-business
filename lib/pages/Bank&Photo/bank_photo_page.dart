import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/shop/shop_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:formz/formz.dart';

// ignore: must_be_immutable
class BankPhotoPage extends StatefulWidget {
  @override
  _BankPhotoPageState createState() => _BankPhotoPageState();
}

class _BankPhotoPageState extends State<BankPhotoPage> {
  TextEditingController bankAccount = TextEditingController();

  TextEditingController interbankAccount = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      floatingActionButton: KeyboardVisibilityBuilder(
        builder: (_, visible) {
          return visible
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => BlocProvider.of<ShopBloc>(context)
                          .add(ShopSubmitted()),
                      child: Container(
                          height: 45,
                          width: wp(80),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                primaryColor,
                                secondaryColor,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Crear tienda',
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: wp(4.5)),
                            ),
                          )),
                    ),
                  ],
                );
        },
      ),
      body: BlocListener<ShopBloc, ShopState>(
        listenWhen: (previous, current) =>
            previous.shopStatus != current.shopStatus,
        listener: (_, state) {
          if (state.shopStatus.isSubmissionSuccess) {
            showAlert(context,
                child: MainPage(),
                title: 'Tienda creada con exito',
                subtitle: 'Listo');
            if (state.shopStatus.isSubmissionFailure) {
              showDialog(
                  context: _,
                  builder: (_) => new AlertDialog(
                        title: new Text("Something go wrong"),
                      ));
            }
            if (state.failShop) {
              showDialog(
                  context: _,
                  builder: (_) => new AlertDialog(
                        title: new Text("Fail to connect"),
                      ));
            }
            if (state.shopStatus.isSubmissionInProgress) {
              showDialog(
                  context: _,
                  builder: (_) => new AlertDialog(
                        title: new Text("Creating shop..."),
                      ));
            }
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
              child: Container(
            child: Column(
              children: [
                _header(hp, wp, context),
                BlocBuilder<ShopBloc, ShopState>(
                  builder: (context, state) {
                    print(state.profilePhoto);
                    print(state.profileTitle);
                    print(state.listImages);
                    return _form(hp, wp, state, context);
                  },
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _form(
      Function hp, Function wp, ShopState state, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      height: hp(76),
      child: ListView(
        children: [
          Text(
            'Foto de perfil y portada',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, fontSize: wp(4.5)),
          ),
          SizedBox(
            height: hp(3),
          ),
          state.listImages[0] != null
              ? MaterialButton(
                  height: hp(8),
                  color: kprimarycolorlight,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () =>
                      BlocProvider.of<ShopBloc>(context).add(OnProfilePhoto()),
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                          radius: wp(5),
                          backgroundImage:
                              Image.file(state.profilePhoto).image),
                      Text(
                        '${state.listImages[0].path.split('/').last}',
                        style: GoogleFonts.lato(fontSize: 10),
                      ),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => BlocProvider.of<ShopBloc>(context)
                              .add(OnRemoveProfilePhoto())),
                    ],
                  ),
                )
              : MaterialButton(
                  height: hp(6),
                  color: kprimarycolorlight,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () =>
                      BlocProvider.of<ShopBloc>(context).add(OnProfilePhoto()),
                  elevation: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_box_rounded,
                        color: Colors.blue,
                      ),
                      Text(' Seleccione foto de perfil')
                    ],
                  ),
                ),
          SizedBox(
            height: hp(2),
          ),
          //PROFILE TITLE IMAGE
          state.listImages[1] != null
              ? MaterialButton(
                  height: hp(8),
                  color: kprimarycolorlight,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () =>
                      BlocProvider.of<ShopBloc>(context).add(OnProfileTitle()),
                  elevation: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                          radius: wp(5),
                          backgroundImage:
                              Image.file(state.profileTitle).image),
                      Text(
                        '${state.listImages[1].path.split('/').last}',
                        style: GoogleFonts.lato(fontSize: 10),
                      ),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => BlocProvider.of<ShopBloc>(context)
                              .add(OnRemoveProfileTitle())),
                    ],
                  ),
                )
              : MaterialButton(
                  height: hp(6),
                  color: kprimarycolorlight,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () =>
                      BlocProvider.of<ShopBloc>(context).add(OnProfileTitle()),
                  elevation: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_box_rounded,
                        color: Colors.blue,
                      ),
                      Text(' Seleccione foto de portada')
                    ],
                  ),
                ),
          SizedBox(
            height: hp(3),
          ),
          Text(
            'Cuenta bancaria',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, fontSize: wp(4.5)),
          ),
          SizedBox(
            height: hp(3),
          ),
          CustomInput(
              function: (value) => BlocProvider.of<ShopBloc>(context)
                  .add(BankAccountChange(value)),
              border:
                  BlocProvider.of<ShopBloc>(context).state.bankAccount.invalid
                      ? Border.all(color: Colors.red)
                      : Border.all(color: Colors.white),
              errorText:
                  BlocProvider.of<ShopBloc>(context).state.bankAccount.invalid
                      ? 'Ingrese su N° de cuenta'
                      : '',
              placeholder: 'N° de cuenta',
              textEditingController: bankAccount),
          CustomInput(
              function: (value) => BlocProvider.of<ShopBloc>(context)
                  .add(InterbankAccountChange(value)),
              border: BlocProvider.of<ShopBloc>(context)
                      .state
                      .interbankAccount
                      .invalid
                  ? Border.all(color: Colors.red)
                  : Border.all(color: Colors.white),
              errorText: BlocProvider.of<ShopBloc>(context)
                      .state
                      .interbankAccount
                      .invalid
                  ? 'Ingrese su N° de cuenta interbancaria'
                  : '',
              placeholder: 'N° de cuenta interbancaria',
              textEditingController: interbankAccount),
          SizedBox(
            height: hp(3),
          ),
          Text(
            'Podras cambiar los datos y añadir nuevas cuentas bancarias una vez registrado',
            style: GoogleFonts.lato(color: kintroNotSelected),
          ),
        ],
      ),
    );
  }

  Material _header(Function hp, Function wp, BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
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
