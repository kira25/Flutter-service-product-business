import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_products_business/helpers/colors.dart';

class ProductCustomInput extends StatelessWidget {
  final Function function;
  final String text;
  final IconData icon;
  const ProductCustomInput({
    @required this.fontSize,
    this.function,
    this.text,
    this.icon,
    this.hp,
    this.iconSize,
    this.isCompleted = false,
  });

  final double fontSize;
  final double iconSize;
  final double hp;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: hp,
        margin: EdgeInsets.only(
          bottom: 20,
        ),
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.lato(
                  color: isCompleted == true ? kdarkcolor : kintroNotSelected,
                  fontSize: fontSize),
            ),
            Icon(
              icon,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
