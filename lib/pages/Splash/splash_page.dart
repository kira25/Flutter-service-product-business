import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/auth/auth_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/Introduction/introduction_page.dart';
import 'package:service_products_business/pages/Login/login_page.dart';
import 'package:service_products_business/widgets/logo.dart';

class SplashPage extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[primaryColor, secondaryColor],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authenticated) {
          CustomRouteTransition(
              child: IntroductionPage(),
              context: context,
              animation: AnimationType.fadeIn,
              replacement: true);
        } else {
          CustomRouteTransition(
              child: LoginPage(),
              context: context,
              animation: AnimationType.fadeIn,
              replacement: true);
        }
      },
      child: SafeArea(
          child: Container(
        height: hp(100),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(
              bottom: hp(2),
            ),
            SizedBox(
              height: hp(22),
            ),
            Container(
              height: hp(18),
              width: wp(30),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Kallpa',
                      style: GoogleFonts.oswald(
                          textStyle: new TextStyle(
                              fontSize: wp(7),
                              foreground: Paint()..shader = linearGradient)),
                    ),
                  ),
                  Positioned(
                    bottom: hp(2),
                    right: 16,
                    child: Text(
                      'Business',
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                              foreground: Paint()..shader = linearGradient,
                              letterSpacing: 1.0,
                              fontSize: wp(4))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    ));
  }

  Future checkLoginState(BuildContext context) {
    //TODO: check login status to send to Login or Profile
    return Future.delayed(Duration(milliseconds: 2000)).then((value) =>
        CustomRouteTransition(
            child: LoginPage(),
            context: context,
            animation: AnimationType.fadeIn,
            replacement: true));
  }
}
