import 'package:flutter/material.dart';
import 'package:service_products_business/helpers/colors.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function function;
  final String errorText;
  final Border border;
  final double hp;
  final int hintMaxLines;
  final int maxlines;

  CustomInput(
      {this.icon,
      @required this.placeholder,
      @required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.function,
      this.errorText = '',
      this.border,
      this.hp,
      this.hintMaxLines,
      this.maxlines = 1});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hp,
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
        enableSuggestions: true,
        autofocus: true,
        maxLines: maxlines,
        controller: textEditingController,
        obscureText: isPassword,
        autocorrect: false,
        onChanged: function,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintMaxLines: hintMaxLines,
            suffixIcon: Icon(icon),
            focusedBorder: InputBorder.none,
            hintStyle: errorText.isNotEmpty
                ? TextStyle(color: Colors.red)
                : TextStyle(color: kintroNotSelected),
            hintText: errorText.isNotEmpty ? errorText : placeholder,
            border: InputBorder.none),
      ),
    );
  }
}
