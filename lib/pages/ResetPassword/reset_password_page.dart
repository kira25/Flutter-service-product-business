import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/forgotpassword/forgotpassword_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/Login/login_page.dart';
import 'package:service_products_business/widgets/custom_input.dart';
import 'package:formz/formz.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmpasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Function hp = Screen(context).hp;
    final Function wp = Screen(context).wp;
    return Scaffold(
        body: SafeArea(
      child: BlocListener<ForgotpasswordBloc, ForgotpasswordState>(
        listenWhen: (previous, current) =>
            previous.statusResetPassword != current.statusResetPassword,
        listener: (context, state) {
          if (state.statusResetPassword.isSubmissionSuccess) {
            CustomRouteTransition(
                context: context,
                child: LoginPage(),
                replacement: true,
                animation: AnimationType.fadeIn);
          } else if (state.statusResetPassword.isSubmissionFailure) {
            showDialog(
                context: context,
                builder: (context) => new AlertDialog(
                      title: new Text("Something go wrong"),
                    ));
          }
        },
        child: Container(
          height: hp(90),
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _formResetPassword(hp, context, wp),
        ),
      ),
    ));
  }

  Widget _formResetPassword(Function hp, BuildContext context, Function wp) {
    return BlocBuilder<ForgotpasswordBloc, ForgotpasswordState>(
      builder: (BuildContext context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomInput(
                function: (value) =>
                    BlocProvider.of<ForgotpasswordBloc>(context)
                        .add(PasswordChanged(value)),
                border: BlocProvider.of<ForgotpasswordBloc>(context)
                        .state
                        .password
                        .invalid
                    ? Border.all(color: Colors.red)
                    : Border.all(color: Colors.white),
                errorText: BlocProvider.of<ForgotpasswordBloc>(context)
                        .state
                        .password
                        .invalid
                    ? 'Coloque su contraseña'
                    : '',
                icon: null,
                isPassword: true,
                placeholder: 'Contraseña',
                textEditingController: passwordCtrl),
            CustomInput(
                function: (value) =>
                    BlocProvider.of<ForgotpasswordBloc>(context)
                        .add(ConfirmPasswordChanged(value)),
                border: BlocProvider.of<ForgotpasswordBloc>(context)
                            .state
                            .confirmPassword
                            .invalid ||
                        confirmpasswordCtrl.text != passwordCtrl.text
                    ? Border.all(color: Colors.red)
                    : Border.all(color: Colors.white),
                errorText: BlocProvider.of<ForgotpasswordBloc>(context)
                            .state
                            .confirmPassword
                            .invalid ||
                        confirmpasswordCtrl.text != passwordCtrl.text
                    ? 'Contraseña repetida incorrecta'
                    : '',
                icon: null,
                isPassword: true,
                placeholder: 'Repetir contraseña',
                textEditingController: confirmpasswordCtrl),
            SizedBox(
              height: hp(10),
            ),
            MaterialButton(
              splashColor: Colors.transparent,
              onPressed: state.statusResetPassword.isValid
                  ? () =>
                      BlocProvider.of<ForgotpasswordBloc>(context)
                          .add(ResetPassword())
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
                          'Confirmar',
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
        );
      },
    );
  }
}
