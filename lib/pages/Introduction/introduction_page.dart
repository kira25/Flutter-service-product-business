import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/auth/auth_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/Login/login_page.dart';
import 'package:service_products_business/pages/ShopInfo/ShopInfo.dart';

// ignore: must_be_immutable
class IntroductionPage extends StatelessWidget {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('./assets/splash_1.jpg'), context,);
    precacheImage(AssetImage('./assets/splash_2.jpg'), context);
    precacheImage(AssetImage('./assets/splash_3.jpg'), context);
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!state.authenticated) {
          CustomRouteTransition(context: context, child: LoginPage());
        }
      },
      child: Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(
          //       icon: IconButton(
          //         icon: Icon(Icons.arrow_back_outlined),
          //         onPressed: () => BlocProvider.of<AuthBloc>(context)
          //             .add(AuthenticationLogout()),
          //       ),
          //       onPressed: null),
          // ),
          body: SafeArea(
              child: Container(
            child: Column(children: [
              _header(hp, wp),
              _textSection(hp, wp),
              SizedBox(height: hp(3),),
              _btnStart(context, 'Empezar', hp, wp),
            ]),
          ))),
    );
  }

  Widget _btnStart(
      BuildContext context, String text, Function hp, Function wp) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: wp(3)),
      child: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () =>
            CustomRouteTransition(context: context, child: ShopInfoPage()),
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
                text,
                style: GoogleFonts.lato(color: Colors.white, fontSize: wp(4.5)),
              ),
            )),
      ),
    );
  }

  Widget _header(Function hp, Function wp) {
    return Container(
      height: hp(60),
      child: PageView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: [
          IntroSlider(
            hp: hp,
            wp: wp,
            first: kintroselected,
            second: kintroNotSelected,
            third: kintroNotSelected,
            path: './assets/splash_1.jpg',
          ),
          IntroSlider(
            hp: hp,
            wp: wp,
            first: kintroNotSelected,
            second: kintroselected,
            third: kintroNotSelected,
            path: './assets/splash_2.jpg',
          ),
          IntroSlider(
            hp: hp,
            wp: wp,
            first: kintroNotSelected,
            second: kintroNotSelected,
            third: kintroselected,
            path: './assets/splash_3.jpg',
          )
        ],
      ),
    );
  }

  Widget _textSection(Function hp, Function wp) {
    return Container(
      height: hp(15),
      margin: EdgeInsets.symmetric(vertical: hp(2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Bienvenido a iKram Business',
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, fontSize: wp(5.5)),
          ),
          Text(
              'Administra los pedidos de tus clientes,\n crea productos y servicios',
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(fontSize: wp(3.5)))
        ],
      ),
    );
  }
}

class IntroSlider extends StatelessWidget {
  final Function hp;
  final Function wp;
  final Color first;
  final Color second;
  final Color third;
  final String path;
  const IntroSlider(
      {this.hp, this.wp, this.first, this.second, this.third, this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: hp(40), left: wp(30), right: wp(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundColor: first,
              radius: wp(2),
            ),
            CircleAvatar(
              backgroundColor: second,
              radius: wp(2),
            ),
            CircleAvatar(
              backgroundColor: third,
              radius: wp(2),
            ),
          ],
        ),
        decoration: BoxDecoration(
            image: DecorationImage(

                colorFilter: ColorFilter.mode(
                    Colors.black87.withOpacity(0.6), BlendMode.darken),
                fit: BoxFit.cover,
                image: AssetImage(path)),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0)
            ]));
  }
}
