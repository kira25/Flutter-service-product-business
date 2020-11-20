import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_products_business/bloc/login/login_bloc.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function function;
  final String errorText;
  final Border border;

  CustomInput(
      {this.icon,
      @required this.placeholder,
      @required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.function,
      this.errorText = '',
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 20),
      decoration: BoxDecoration(
          border: border,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        autofocus: true,
        controller: textEditingController,
        obscureText: isPassword,
        autocorrect: false,
        onChanged: function,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            suffixIcon: Icon(icon),
            focusedBorder: InputBorder.none,
            hintStyle:
                errorText.isNotEmpty ? TextStyle(color: Colors.red) : null,
            hintText: errorText.isNotEmpty ? errorText : placeholder,
            border: InputBorder.none),
      ),
    );
  }
}
