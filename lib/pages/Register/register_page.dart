import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/register/register_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/Introduction/introduction_page.dart';
import 'package:service_products_business/pages/Login/login_page.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:formz/formz.dart';

enum documentType { DNI }

class RegisterPage extends StatelessWidget {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController identifier = TextEditingController();
  final TextEditingController cellphone = TextEditingController();
  final TextEditingController shopName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Function hp = Screen(context).hp;

    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                CustomRouteTransition(
                    context: context,
                    child: LoginPage(),
                    animation: AnimationType.fadeIn,
                    replacement: true);
              }),
          title: Text(
            'Solicitud de registro',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.failRegister == true) {
              showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  title: new Text('Fail to connect'),
                ),
              );
            } else if (state.status.isSubmissionFailure) {
              showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                  title: new Text('Email already exist'),
                ),
              );
            } else if (state.status.isSubmissionSuccess) {
              CustomRouteTransition(
                  context: context,
                  child: IntroductionPage(),
                  replacement: true,
                  animation: AnimationType.fadeIn);
            }
          },
          child: SingleChildScrollView(
            child: Container(
              height: hp(100),
              width: double.infinity,
              child: Column(
                children: [
                  _form(context),
                ],
              ),
            ),
          ),
        )));
  }

  Widget _form(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Container(
        padding: EdgeInsets.symmetric(horizontal: wp(4)),
        height: hp(100),
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                //FORM HEADER
                _formHeader(hp, wp),
                CustomInput(
                    function: (value) => BlocProvider.of<RegisterBloc>(context)
                        .add(FirstNameChanged(value)),
                    border: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .firstname
                            .invalid
                        ? Border.all(color: Colors.red)
                        : Border.all(color: Colors.white),
                    errorText: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .firstname
                            .invalid
                        ? 'Coloque su nombre'
                        : '',
                    keyboardType: TextInputType.name,
                    placeholder: 'Nombres completos',
                    textEditingController: firstname),
                CustomInput(
                    function: (value) => BlocProvider.of<RegisterBloc>(context)
                        .add(LastNameChanged(value)),
                    border: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .lastname
                            .invalid
                        ? Border.all(color: Colors.red)
                        : Border.all(color: Colors.white),
                    errorText: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .lastname
                            .invalid
                        ? 'Coloque su apellido'
                        : '',
                    keyboardType: TextInputType.name,
                    placeholder: 'Apellidos completos',
                    textEditingController: lastname),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20),
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
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
                      value: documentType.DNI.toString(),
                      items: [
                        DropdownMenuItem(
                          child: Text('DNI'),
                          value: documentType.DNI.toString(),
                        )
                      ],
                      onChanged: (value) {
                        //TODO: set the identifier
                        print(value);
                      },
                    ),
                  ),
                ),
                CustomInput(
                    function: (value) => BlocProvider.of<RegisterBloc>(context)
                        .add(IdentifierChanged(value)),
                    border: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .identifier
                            .invalid
                        ? Border.all(color: Colors.red)
                        : Border.all(color: Colors.white),
                    errorText: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .identifier
                            .invalid
                        ? 'Coloque su DNI'
                        : '',
                    icon: null,
                    placeholder: 'N° de documento',
                    keyboardType: TextInputType.number,
                    textEditingController: identifier),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20),
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
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
                      value: 'Peru',
                      items: [
                        DropdownMenuItem(
                          child: Text('Peru +51'),
                          value: 'Peru',
                        )
                      ],
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ),
                CustomInput(
                    function: (value) => BlocProvider.of<RegisterBloc>(context)
                        .add(CellphoneChanged(value)),
                    border: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .cellphone
                            .invalid
                        ? Border.all(color: Colors.red)
                        : Border.all(color: Colors.white),
                    errorText: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .cellphone
                            .invalid
                        ? 'Coloque su telefono'
                        : '',
                    icon: null,
                    placeholder: 'Telefono',
                    keyboardType: TextInputType.number,
                    textEditingController: cellphone),
                CustomInput(
                    function: (value) => BlocProvider.of<RegisterBloc>(context)
                        .add(ShopNameChanged(value)),
                    border: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .shopname
                            .invalid
                        ? Border.all(color: Colors.red)
                        : Border.all(color: Colors.white),
                    errorText: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .shopname
                            .invalid
                        ? 'Coloque su tienda'
                        : '',
                    icon: null,
                    keyboardType: TextInputType.name,
                    placeholder: 'Nombre de la tienda',
                    textEditingController: shopName),
                CustomInput(
                    function: (value) => BlocProvider.of<RegisterBloc>(context)
                        .add(EmailChanged(value)),
                    border:
                        BlocProvider.of<RegisterBloc>(context).state.registerEmail.invalid
                            ? Border.all(color: Colors.red)
                            : Border.all(color: Colors.white),
                    errorText:
                        BlocProvider.of<RegisterBloc>(context).state.registerEmail.invalid
                            ? 'Coloque su correo'
                            : '',
                    icon: null,
                    keyboardType: TextInputType.emailAddress,
                    placeholder: 'Correo electornico',
                    textEditingController: email),
                CustomInput(
                    function: (value) => BlocProvider.of<RegisterBloc>(context)
                        .add(PasswordChanged(value)),
                    border: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .registerPassword
                            .invalid
                        ? Border.all(color: Colors.red)
                        : Border.all(color: Colors.white),
                    errorText: BlocProvider.of<RegisterBloc>(context)
                            .state
                            .registerPassword
                            .invalid
                        ? 'Coloque su contraseña'
                        : '',
                    icon: null,
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    placeholder: 'Contraseña',
                    textEditingController: password),
                CustomInput(
                    function: (value) => BlocProvider.of<RegisterBloc>(context)
                        .add(ConfirmPasswordChanged(value)),
                    border: BlocProvider.of<RegisterBloc>(context)
                                .state
                                .registerConfirmPassword
                                .invalid ||
                            confirmPassword.text != password.text
                        ? Border.all(color: Colors.red)
                        : Border.all(color: Colors.white),
                    errorText: BlocProvider.of<RegisterBloc>(context)
                                .state
                                .registerConfirmPassword
                                .invalid ||
                            confirmPassword.text != password.text
                        ? 'Contraseña repetida incorrecta'
                        : '',
                    icon: null,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    placeholder: 'Repetir contraseña',
                    textEditingController: confirmPassword),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Al registrarte aceptas los ',
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(color: Color(0xFF757575)),
                          fontSize: wp(4)),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //TODO: Implement terminos y condiciones

                                print('Go to Register Page');
                              },
                            text: 'Terminos y condiciones',
                            style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    fontSize: wp(4),
                                    decoration: TextDecoration.underline,
                                    color: Color(0xFF0675E3))))
                      ]),
                ),
                SizedBox(
                  height: hp(3),
                ),
                _sendActionButton(context),
                SizedBox(
                  height: hp(3),
                ),
              ],
            );
          },
        ));
  }

  Container _formHeader(Function hp, Function wp) {
    return Container(
      margin: EdgeInsets.only(top: hp(3), bottom: hp(3)),
      padding: EdgeInsets.symmetric(horizontal: wp(4)),
      child: Row(
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
                  FontAwesomeIcons.user,
                  color: Colors.white,
                  size: wp(8),
                )),
          ),
          SizedBox(
            width: wp(10),
          ),
          Text(
            'Completa los siguientes datos',
            style: GoogleFonts.lato(fontSize: wp(4.5)),
          ),
        ],
      ),
    );
  }



  Widget _sendActionButton(BuildContext context) {
    final Function wp = Screen(context).wp;
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : MaterialButton(
                splashColor: Colors.transparent,
                onPressed: () => state.status.isValid
                    ? BlocProvider.of<RegisterBloc>(context)
                        .add(RegisterSubmitted())
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
                  child: Center(
                    child: Text(
                      'Enviar solicitud',
                      style: GoogleFonts.oswald(
                          color: Colors.white, fontSize: wp(4.5)),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
