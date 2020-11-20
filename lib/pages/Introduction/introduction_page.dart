import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_products_business/bloc/auth/auth_bloc.dart';
import 'package:service_products_business/helpers/route_transitions.dart';
import 'package:service_products_business/pages/Login/login_page.dart';

class IntroductionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!state.authenticated) {
          CustomRouteTransition(context: context, child: LoginPage());
        }
        // TODO: implement listener
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                onPressed: () => BlocProvider.of<AuthBloc>(context)
                    .add(AuthenticationLogout()),
              ),
              onPressed: null),
        ),
        body: Center(
          child: Text('IntroductionPage'),
        ),
      ),
    );
  }
}
