import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/show_alert.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dialogTitle;
  final Function function;
  final double wp;

  const Header({
    Key key,
    this.title,
    this.subtitle,
    this.dialogTitle,
    this.wp,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      customShowDialog(
                        context,
                        titleOption1: 'Salir',
                        actionOption1: function,
                        titleOption2: 'Seguir editando',
                        actionOption2: () => Navigator.pop(context),
                        title: dialogTitle,
                      );
                    }),
                Text(
                  title,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, fontSize: wp),
                ),
              ],
            ),
            Container(
              height: 30,
              width: 60,
              child: Center(
                  child: Text(
                subtitle,
                style: GoogleFonts.lato(color: kprimarycolorlight),
              )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    primaryColor,
                    secondaryColor,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
