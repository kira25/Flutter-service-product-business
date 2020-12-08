import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_products_business/helpers/colors.dart';

class CategoryOptions extends StatelessWidget {
  final String option;
  final Function function;
  final Function wp;
  final bool border;
  const CategoryOptions(
      {this.option, this.function, this.wp, this.border = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.only(bottom: wp(3)),
        margin: EdgeInsets.only(bottom: wp(4)),
        width: double.infinity,
        decoration: border
            ? BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: kintroNotSelected, width: 1)))
            : BoxDecoration(),
        child: Text(option,
            style: GoogleFonts.lato(fontSize: wp(4.5), color: kdarkcolor)),
      ),
    );
  }
}
