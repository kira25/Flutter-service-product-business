import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/helpers/colors.dart';

class Logo extends StatelessWidget {
  final double height;
  final double width;
  final double bottom;

  const Logo({this.height = 120, this.width = 120, this.bottom});

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [primaryColor, secondaryColor])),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Kallpa',
              style: GoogleFonts.oswald(
                  textStyle: TextStyle(color: Colors.white, fontSize: wp(7))),
            ),
          ),
          Positioned(
            bottom: bottom,
            right: 16,
            child: Text(
              'Business',
              style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.0,
                      fontSize: wp(4))),
            ),
          ),
        ],
      ),
    );
  }
}
