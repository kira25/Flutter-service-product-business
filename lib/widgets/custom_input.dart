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
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onFocus;
  final bool autofocus;

  CustomInput(
      {this.onFocus,
      this.icon,
      @required this.placeholder,
      @required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.function,
      this.errorText = '',
      this.border,
      this.hp,
      this.hintMaxLines,
      this.maxlines = 1,
      this.textInputAction,
      this.focusNode,
      this.autofocus});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hp,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 25, right: 15),
      decoration: BoxDecoration(
          border: border,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
            ),
          ],
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20)),
      child: TextField(
        
        onEditingComplete: onFocus,
        focusNode: focusNode,
        autofocus: autofocus != null ? autofocus : true,
        textInputAction: textInputAction,
        enableSuggestions: true,
        maxLines: maxlines,
        controller: textEditingController,
        obscureText: isPassword,
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
