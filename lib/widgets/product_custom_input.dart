import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCustomInput extends StatelessWidget {

  final Function function;
  final String text;
  final IconData icon;
  const ProductCustomInput({
    @required this.wp,
    this.function,
    this.text,
    this.icon, this.hp,
  });

  final Function wp;
  final double hp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: hp,
        margin: EdgeInsets.only(bottom: 20, top: 20),
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
              style: GoogleFonts.oswald(color: Colors.black, fontSize: wp(4.5)),
            ),
            Icon(
              icon,
              size: 23,
            ),
          ],
        ),
      ),
    );
  }
}
