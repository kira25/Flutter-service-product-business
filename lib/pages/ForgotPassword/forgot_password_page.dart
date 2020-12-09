import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/forgotpassword/forgotpassword_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/pages/Login/login_page.dart';
import 'package:service_products_business/pages/VerifyPasswordPin/verify_password_pin_page.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:formz/formz.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: Text(
            'Recuperar contraseña',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () => CustomRouteTransition(
                  context: context,
                  child: LoginPage(),
                  animation: AnimationType.fadeIn,
                  replacement: true)),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: BlocListener<ForgotpasswordBloc, ForgotpasswordState>(
            listenWhen: (previous, current) =>
                previous.status != current.status ||
                previous.failSendEmail != current.failSendEmail,
            listener: (context, state) {
              if (state.status.isSubmissionFailure) {
                showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                          title: new Text("Email not exist"),
                        ));
              } else if (state.failSendEmail) {
                showDialog(
                    context: context,
                    builder: (context) => new AlertDialog(
                          title: new Text("Fail to connect"),
                        ));
              } else if (state.status.isSubmissionSuccess) {
                showAlert(
                  context,
                  title: 'Correo enviado con exito',
                  child: VerifyPasswordPinPage(),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: wp(4)),
              child: _sendEmail(wp, hp, context),
            ),
          )),
        ));
  }

  Widget _sendEmail(Function wp, Function hp, BuildContext context) {
    return BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: wp(5), vertical: hp(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          final Rect rect = Rect.fromLTRB(0, 0, 50, 50);
                          LinearGradient gradient = LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [primaryColor, secondaryColor]);
                          return gradient.createShader(rect);
                        },
                        child: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.white,
                          size: wp(8),
                        )),
                  ),
                  SizedBox(
                    height: hp(2),
                  ),
                  Text('Ingresa el correo registrado en Kallpa\nBusiness',
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontSize: wp(4),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: hp(2),
                  ),
                  Text(
                      'Te enviaremos un correo para restablecer tu contraseña. Revisa tu bandeja de entrada o spam',
                      style: GoogleFonts.lato(
                        fontSize: wp(4),
                      )),
                ],
              ),
            ),
            // SizedBox(height: hp(30),),
            Column(
              children: [
                CustomInput(
                    function: (value) =>
                        BlocProvider.of<ForgotpasswordBloc>(context)
                            .add(EmailChanged(value)),
                    border: BlocProvider.of<ForgotpasswordBloc>(context)
                            .state
                            .email
                            .invalid
                        ? Border.all(color: Colors.red)
                        : Border.all(color: Colors.white),
                    errorText: BlocProvider.of<ForgotpasswordBloc>(context)
                            .state
                            .email
                            .invalid
                        ? 'Coloque su correo'
                        : '',
                    icon: null,
                    keyboardType: TextInputType.emailAddress,
                    placeholder: 'Correo electrónico',
                    textEditingController: emailCtrl),
                MaterialButton(
                  splashColor: Colors.transparent,
                  onPressed: state.status.isValid
                      ? () =>
                          BlocProvider.of<ForgotpasswordBloc>(context)
                              .add(SendEmail())
                      : null,
                  child: Container(
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: wp(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Enviar',
                              style: GoogleFonts.lato(
                                  color: Colors.white, fontSize: wp(4.5)),
                            ),
                            CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: wp(4),
                                ))
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
