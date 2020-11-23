import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/widgets/custom_input.dart';

class BankPhotoPage extends StatelessWidget {
  TextEditingController bankAccount = TextEditingController();
  TextEditingController interbankAccount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () =>
                CustomRouteTransition(context: context, child: BankPhotoPage()),
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
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          child: Column(
            children: [
              _header(hp, wp,context),
              _form(hp, wp),
            ],
          ),
        )),
      ),
    );
  }

  Widget _form(Function hp, Function wp) {
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
          MaterialButton(
            height: hp(6),
            color: kprimarycolorlight,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              print('foto perfil');
            },
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
          MaterialButton(
            height: hp(6),
            onPressed: () {
              print('foto portada');
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            elevation: 5,
            color: kprimarycolorlight,
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
              placeholder: 'N° de cuenta', textEditingController: bankAccount),
          CustomInput(
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
            IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
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
