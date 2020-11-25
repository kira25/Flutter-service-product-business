import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/forgotpassword/forgotpassword_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/ResetPassword/reset_password_page.dart';

class VerifyPasswordPinPage extends StatelessWidget {
  final TextEditingController pinCtrl = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
            child: BlocListener<ForgotpasswordBloc, ForgotpasswordState>(
          listenWhen: (previous, current) =>
              previous.failPin != current.failPin,
          listener: (context, state) {
            if (state.failPin == FailPinType.success) {
              print('Correct pin');
              CustomRouteTransition(
                  context: context, child: ResetPasswordPage());
            } else if (state.failPin == FailPinType.fail) {
              showDialog(
                  context: context,
                  builder: (context) => new AlertDialog(
                        title: new Text("Bad pin code"),
                      ));
            }
          },
          child: Container(
            child: verifyPasswordToken(wp, hp, context),
          ),
        )));
  }

  Widget verifyPasswordToken(Function wp, Function hp, BuildContext context) {
    return BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
      builder: (_, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Por favor ingresa el codigo enviado a tu correo'),
            PinCodeTextField(
              pinBoxColor: kprimarycolorlight,
              errorBorderColor: kwrongAnswer,
              controller: pinCtrl,
              pinTextStyle: TextStyle(fontSize: wp(6)),
              pinBoxRadius: 10,
              pinBoxHeight: 60,
              hasError: false,
              pinBoxWidth: 53,
              highlight: true,
              maxLength: 6,
              keyboardType: TextInputType.number,
              isCupertino: true,
              highlightColor: primaryColor,
              highlightPinBoxColor: kprimarycolorlight,
              hasTextBorderColor: primaryColor,
              defaultBorderColor: secondaryColor,
              onTextChanged: (text) {},
              onDone: (text) {
                BlocProvider.of<ForgotpasswordBloc>(context)
                    .add(PinChanged(pin: text));
                print(text);
              },
            ),
            MaterialButton(
              onPressed: pinCtrl.text != null
                  ? () {
                      BlocProvider.of<ForgotpasswordBloc>(context)
                          .add(VerifyPasswordPin());
                      print('pin: ${pinCtrl.text}');
                      pinCtrl.text = '';
                    }
                  : null

              ,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: wp(5)),
                  height: 45,
                  width: double.infinity,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Validar',
                        style: GoogleFonts.lato(
                            color: Colors.white, fontSize: wp(4.5)),
                      ),
                    ],
                  )),
            ),
            Column(
              children: [
                Text('En caso, no haber recibido el codigo'),
                SizedBox(
                  height: hp(4),
                ),
                GestureDetector(
                    onTap: () {
                      BlocProvider.of<ForgotpasswordBloc>(context)
                          .add(SendEmail());
                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('Codigo enviado',
                              style: TextStyle(fontSize: wp(4)))));
                    },
                    child: Text('Reenviar codigo')),
              ],
            ),
          ],
        );
      },
    );
  }
}
