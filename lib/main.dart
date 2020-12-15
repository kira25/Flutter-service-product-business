import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:service_products_business/bloc/auth/auth_bloc.dart';
import 'package:service_products_business/bloc/forgotpassword/forgotpassword_bloc.dart';
import 'package:service_products_business/bloc/login/login_bloc.dart';
import 'package:service_products_business/bloc/orders_products/orders_products_bloc.dart';
import 'package:service_products_business/bloc/orders_services/orders_services_bloc.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/bloc/register/register_bloc.dart';
import 'package:service_products_business/bloc/services/services_bloc.dart';
import 'package:service_products_business/bloc/shop/shop_bloc.dart';
import 'package:service_products_business/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc()..add(AuthenticationStatus()),
        ),
        BlocProvider(
          create: (_) => LoginBloc(),
        ),
        BlocProvider(
          create: (_) => ForgotpasswordBloc(),
        ),
        BlocProvider(
          create: (_) => RegisterBloc(),
        ),
        BlocProvider<ShopBloc>(
          create: (_) => ShopBloc(),
        ),
        BlocProvider(
          create: (_) => OrdersProductsBloc(),
        ),
        BlocProvider(
          create: (_) => OrdersServicesBloc(),
        ),
        BlocProvider(
          create: (_) => ProductsBloc(),
        ),
        BlocProvider(
          create: (_) => ServicesBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kallpa Business',
        initialRoute: SPLASH_PAGE,
        routes: appRoutes,
      ),
    );
  }
}
