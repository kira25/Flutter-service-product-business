import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/helpers/route_transitions.dart';

showAlert(BuildContext context, {String title, String subtitle, Widget child}) {
  final Function wp = Screen(context).wp;
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          CupertinoDialogAction(
              child: Text('Ok'), onPressed: () => Navigator.pop(context))
        ],
      ),
    );
  }
  //ANDROID
  showDialog(
    
    context: context,
    builder: (context) => AlertDialog(

      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Icon(
          Icons.check_circle_outline,
          size: wp(18),
          color: Color(0xFF3FE391),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            color: Colors.grey,
            width: double.infinity,
            height: 1,
          )
        ],
      ),
      actions: [
        MaterialButton(
            child: Text(
              'Entendido',
              style: GoogleFonts.lato(fontSize: wp(4.5)),
            ),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => CustomRouteTransition(
                context: context,
                child: child,
                animation: AnimationType.fadeIn,
                replacement: true)),
        SizedBox(
          width: wp(18),
        )
      ],
    ),
  );
}
