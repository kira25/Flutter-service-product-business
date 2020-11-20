import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:service_products_business/bloc/forgotpassword/forgotpassword_bloc.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/route_transitions.dart';

class CustomButton extends StatelessWidget {
  final BuildContext context;
  final String text;
  final Widget child;
  final bool replacement;
  final ForgotpasswordEvent event;

  const CustomButton(
      {this.context, this.text, this.child, this.replacement, this.event});

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    return MaterialButton(
      onPressed: () => BlocProvider.of<ForgotpasswordBloc>(context).add(event),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style:
                    GoogleFonts.oswald(color: Colors.white, fontSize: wp(4.5)),
              ),
              SizedBox(
                width: wp(10),
              ),
              CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ))
            ],
          )),
    );
  }
}
