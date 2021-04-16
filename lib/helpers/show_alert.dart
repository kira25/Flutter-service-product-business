import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';

showAlert(
  BuildContext context, {
  String title,
  String subtitle,
  Widget child,
}) {
  final Function wp = Screen(context).wp;
  final Function hp = Screen(context).hp;
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
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: hp(1.5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: wp(18),
              color: kdialogicon,
            ),
          ],
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
                fontWeight: FontWeight.bold, fontSize: wp(4.5)),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            color: kintroNotSelected,
            width: double.infinity,
            height: 1,
          )
        ],
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: wp(26)),
      actions: [
        MaterialButton(
            child: Text(
              subtitle != null ? subtitle : 'Entendido',
              style: GoogleFonts.lato(fontSize: wp(4)),
            ),
            elevation: 5,
            textColor: kintroselected,
            onPressed: () => child == null
                ? Navigator.pop(context)
                : CustomRouteTransition(
                    context: context,
                    child: child,
                    animation: AnimationType.fadeIn,
                    replacement: true)),
      ],
    ),
  );
}

//DISCARD CREATE PRODUCT OR SERVICE
customShowDialog(BuildContext context,
    {String title,
    String titleOption1,
    Color color1 = kdarkcolor,
    Function actionOption1,
    String titleOption2,
    Color color2 = kdarkcolor,
    Function actionOption2}) {
  final Function wp = Screen(context).wp;
  final Function hp = Screen(context).hp;
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: hp(1.5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold, fontSize: wp(4.5)),
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
              child: Text(titleOption1,
                  style:
                      GoogleFonts.lato(fontSize: wp(4))),
              elevation: 5,
              textColor: color1,
              onPressed: actionOption1),
          MaterialButton(
              child: Text(
                titleOption2,
                style: GoogleFonts.lato(fontSize: wp(4)),
              ),
              elevation: 5,
              textColor: color2,
              onPressed:  actionOption2),
        ],
      ),
    );
  }
  //ANDROID
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      content: Padding(
        padding: EdgeInsets.only(top: hp(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold, fontSize: wp(4.5)),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: wp(6)),
          child: MaterialButton(
              child: Text(titleOption1,
                  style:
                      GoogleFonts.lato(fontSize: wp(4),)),
              elevation: 5,
              textColor: color1,
              onPressed: actionOption1),
        ),
        Padding(
          padding: EdgeInsets.only(right: wp(6)),
          child: MaterialButton(
              child: Text(
                titleOption2,
                style: GoogleFonts.lato(fontSize: wp(4)),
              ),
              elevation: 5,
              textColor: color2,
              onPressed:  actionOption2),
        ),
      ],
    ),
  );
}
