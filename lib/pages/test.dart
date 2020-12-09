import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_products_business/helpers/colors.dart';
import 'package:service_products_business/helpers/show_alert.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kprimarycolorlight,
      child: Center(
        child: MaterialButton(
          onPressed: () {
            showAlert(context, title: 'Producto creado2', subtitle: 'Aceptar2');
          },
          child: Text('HOla'),
        ),
      ),
    );
  }
}

