import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const CustomFloatingActionButton({
    Key key,
    @required this.wp,
    this.text,
    this.onPressed,
  }) : super(key: key);

  final Function wp;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (_, visible) {
        return visible
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: onPressed,
                    child: Container(
                        height: 45,
                        width: wp(80),
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
                            style: GoogleFonts.oswald(
                                color: Colors.white, fontSize: wp(4.5)),
                          ),
                        )),
                  ),
                ],
              );
      },
    );
  }
}
