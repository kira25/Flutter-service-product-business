import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/login/login_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/helpers/show_alert.dart';
import 'package:service_products_business/pages/ForgotPassword/forgot_password_page.dart';
import 'package:service_products_business/pages/Introduction/introduction_page.dart';
import 'package:service_products_business/pages/Register/register_page.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:service_products_business/widgets/logo.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child:
                    BlocListener<LoginBloc, LoginState>(listener: (_, state) {
                  if (state.status.isSubmissionFailure) {
                    showDialog(
                        context: _,
                        builder: (_) => new AlertDialog(
                              title: new Text("Bad credentials"),
                            ));
                  }
                  if (state.failLogging) {
                    showDialog(
                        context: _,
                        builder: (_) => new AlertDialog(
                              title: new Text("Fail to connect"),
                            ));
                  }
                  if (state.status.isSubmissionSuccess) {
                    CustomRouteTransition(
                        animation: AnimationType.fadeIn,
                        context: context,
                        child: IntroductionPage(),
                        replacement: true);
                  }
                }, child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (BuildContext context, state) {
                    return Container(
                      child: Column(
                        children: [
                          _header(hp, wp),
                          Container(
                            height: hp(45),
                            margin: EdgeInsets.only(top: hp(4)),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomInput(
                                    function: (value) =>
                                        BlocProvider.of<LoginBloc>(context)
                                            .add(EmailChanged(value)),
                                    border: BlocProvider.of<LoginBloc>(context)
                                            .state
                                            .email
                                            .invalid
                                        ? Border.all(color: Colors.red)
                                        : Border.all(color: Colors.white),
                                    errorText:
                                        BlocProvider.of<LoginBloc>(context)
                                                .state
                                                .email
                                                .invalid
                                            ? 'Coloque su correo'
                                            : '',
                                    placeholder: 'Correo electronico',
                                    isPassword: false,
                                    keyboardType: TextInputType.emailAddress,
                                    textEditingController: emailCtrl),
                                CustomInput(
                                    function: (value) =>
                                        BlocProvider.of<LoginBloc>(context)
                                            .add(PasswordChanged(value)),
                                    border: BlocProvider.of<LoginBloc>(context)
                                            .state
                                            .password
                                            .invalid
                                        ? Border.all(color: Colors.red)
                                        : Border.all(color: Colors.white),
                                    errorText:
                                        BlocProvider.of<LoginBloc>(context)
                                                .state
                                                .password
                                                .invalid
                                            ? 'Coloque su contraseña'
                                            : '',
                                    placeholder: 'Contraseña',
                                    isPassword: true,
                                    keyboardType: TextInputType.emailAddress,
                                    textEditingController: passwCtrl),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () => CustomRouteTransition(
                                          animation: AnimationType.fadeIn,
                                          replacement: true,
                                          context: context,
                                          child: ForgotPasswordPage()),
                                      child: Text(
                                        '¿Olvidaste tu contraseña',
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: hp(2),
                                ),
                                state.status.isSubmissionInProgress
                                    ? const CircularProgressIndicator()
                                    : MaterialButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: () => state.status.isValid
                                            ? BlocProvider.of<LoginBloc>(
                                                    context)
                                                .add(LoginSubmitted())
                                            : null,
                                        child: Container(
                                            height: 45,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Iniciar sesion',
                                                  style: GoogleFonts.oswald(
                                                      color: Colors.white,
                                                      fontSize: wp(4.5)),
                                                ),
                                                SizedBox(
                                                  width: wp(10),
                                                ),
                                                CircleAvatar(
                                                    radius: 12,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                    ))
                                              ],
                                            )),
                                      ),
                                SizedBox(
                                  height: hp(2),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'No tienes cuenta? ',
                                      style: GoogleFonts.oswald(
                                          textStyle: TextStyle(
                                              color: Color(0xFF757575)),
                                          fontSize: wp(4.5)),
                                      children: [
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                //TODO: Implement register

                                                CustomRouteTransition(
                                                    context: context,
                                                    child: RegisterPage(),
                                                    animation:
                                                        AnimationType.fadeIn,
                                                    replacement: true);
                                                print('Go to Register Page');
                                              },
                                            text: 'Registrate',
                                            style: GoogleFonts.oswald(
                                                textStyle: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Color(0xFF0675E3))))
                                      ]),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )))));
  }

  Container _header(Function hp, Function wp) {
    return Container(
      height: hp(45),
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black87.withOpacity(0.6), BlendMode.darken),
              fit: BoxFit.cover,
              image: AssetImage('./assets/store_manager.jpg')),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Logo(
            height: hp(12),
            width: wp(25),
            bottom: hp(1),
          ),
          Text(
            'Bienvenido \n a Kallpa Business',
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(color: Colors.white, fontSize: wp(7)),
          ),
          Text(
            'Los mejores productos y servicios\n en una sola aplicacion',
            textAlign: TextAlign.center,
            style: GoogleFonts.oswald(color: Colors.white, fontSize: wp(4)),
          )
        ],
      ),
    );
  }
}
