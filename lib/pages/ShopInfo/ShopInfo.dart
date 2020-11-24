import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/shop/shop_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/Bank&Photo/bank_photo_page.dart';
import 'package:service_products_business/widgets/custom_input.dart';

enum deliveryTime { ONE_HR, TWO_HR, THREE_HR }

// ignore: must_be_immutable
class ShopInfo extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController info = TextEditingController();
  TextEditingController dpto = TextEditingController();
  TextEditingController address = TextEditingController();
  // TextEditingController deliveryTime = TextEditingController();
  TextEditingController whatsapp = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController instagram = TextEditingController();

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
                    'Siguiente',
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
              Material(
                elevation: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Bienvenido',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Container(
                        height: 30,
                        width: 60,
                        child: Center(
                            child: Text(
                          '1/2',
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
              ),
              BlocBuilder<ShopBloc, ShopState>(
                builder: (context, state) {
                  return _form(hp, wp, state, context);
                },
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _form(
      Function hp, Function wp, ShopState state, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 20),
      height: hp(76),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            'Completar los siguientes datos de tu tienda antes de empezar.',
            style: GoogleFonts.lato(color: kintroNotSelected),
          ),
          SizedBox(
            height: hp(3),
          ),
          Text('Informacion de tienda',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          // CustomInput(
          //   placeholder: 'Nombre',
          //   textEditingController: name,
          //   hintMaxLines: 1,
          // ),
          CustomInput(
            function: (String value) => BlocProvider.of<ShopBloc>(context)
                .add(DescriptionChange(description: value.trim())),
            border: BlocProvider.of<ShopBloc>(context).state.description.invalid
                ? Border.all(color: Colors.red)
                : Border.all(color: Colors.white),
            errorText:
                BlocProvider.of<ShopBloc>(context).state.description.invalid
                    ? 'Complete su información'
                    : '',
            placeholder: 'Informacion',
            keyboardType: TextInputType.multiline,
            textEditingController: info,
            hp: hp(30),
            hintMaxLines: 4,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(0, 5),
                      blurRadius: 5),
                ],
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: state.deliveryTime,
                items: [
                  DropdownMenuItem(
                    child: Text('1 hrs'),
                    value: '1 hrs',
                  ),
                  DropdownMenuItem(
                    child: Text('2 hrs'),
                    value: '2 hrs',
                  ),
                  DropdownMenuItem(
                    child: Text('3 hrs'),
                    value: '3 hrs',
                  )
                ],
                onChanged: (value) => BlocProvider.of<ShopBloc>(context)
                    .add(DeliveryChange(value)),
              ),
            ),
          ),
          CustomInput(
            function: (value) =>
                BlocProvider.of<ShopBloc>(context).add(StateChange(value)),
            border: BlocProvider.of<ShopBloc>(context).state.state.invalid
                ? Border.all(color: Colors.red)
                : Border.all(color: Colors.white),
            errorText: BlocProvider.of<ShopBloc>(context).state.state.invalid
                ? 'Coloque su departamento'
                : '',
            placeholder: 'Departamento - Provincia - Distrito',
            textEditingController: dpto,
            hintMaxLines: 1,
          ),
          CustomInput(
            function: (value) =>
                BlocProvider.of<ShopBloc>(context).add(AddressChange(value)),
            border: BlocProvider.of<ShopBloc>(context).state.address.invalid
                ? Border.all(color: Colors.red)
                : Border.all(color: Colors.white),
            errorText: BlocProvider.of<ShopBloc>(context).state.address.invalid
                ? 'Coloque su direccion'
                : '',
            placeholder: 'Direccion',
            textEditingController: address,
            hintMaxLines: 1,
          ),
          // CustomInput(
          //   placeholder: 'Tiempo aprox de entrega(Productos)',
          //   textEditingController: deliveryTime,
          //   hintMaxLines: 1,
          // ),
          CustomInput(
            function: (value) =>
                BlocProvider.of<ShopBloc>(context).add(WhatsappChange(value)),
            border: BlocProvider.of<ShopBloc>(context).state.whatsapp.invalid
                ? Border.all(color: Colors.red)
                : Border.all(color: Colors.white),
            errorText: BlocProvider.of<ShopBloc>(context).state.whatsapp.invalid
                ? 'Coloque su whatsapp'
                : '',
            placeholder: 'WhatsApp',
            textEditingController: whatsapp,
            hintMaxLines: 1,
          ),
          SizedBox(
            height: hp(3),
          ),
          Text('Link de redes sociales (opcional)',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, fontSize: wp(4.5))),
          SizedBox(
            height: hp(3),
          ),
          CustomInput(
            function: (value) =>
                BlocProvider.of<ShopBloc>(context).add(FacebookChange(value)),
            placeholder: 'Facebook',
            textEditingController: facebook,
            hintMaxLines: 1,
          ),
          CustomInput(
            function: (value) =>
                BlocProvider.of<ShopBloc>(context).add(InstagramChange(value)),
            placeholder: 'Instagram',
            textEditingController: instagram,
            hintMaxLines: 1,
          ),
        ],
      ),
    );
  }
}
