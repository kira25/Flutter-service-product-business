import 'package:flutter/material.dart';
import 'package:service_products_business/pages/Bank&Photo/bank_photo_page.dart';
import 'package:service_products_business/pages/Introduction/introduction_page.dart';
import 'package:service_products_business/pages/Orders/orders_page.dart';
import 'package:service_products_business/pages/ResetPassword/reset_password_page.dart';
import 'package:service_products_business/pages/ShopInfo/ShopInfo.dart';
import 'package:service_products_business/pages/Splash/splash_page.dart';
import 'package:service_products_business/pages/Login/login_page.dart';
import 'package:service_products_business/pages/Register/register_page.dart';
import 'package:service_products_business/pages/VerifyPasswordPin/verify_password_pin_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  SPLASH_SCREEN: (_) => SplashPage(),
  LOGIN_SCREEN: (_) => LoginPage(),
  REGISTER_SCREEN: (_) => RegisterPage(),
  VERIFY_PASSWORD_SCREEN: (_) => VerifyPasswordPinPage(),
  RESET_PASSWORD: (_) => ResetPasswordPage(),
  INTRODUCTION_PAGE: (_) => IntroductionPage(),
  SHOP_INFO: (_) => ShopInfoPage(),
  BANK_PHOTO: (_) => BankPhotoPage(),
  ORDER_SCREEN: (_) => OrdersPage(),
};

const SPLASH_SCREEN = 'SPLASH_SCREEN';
const LOGIN_SCREEN = 'LOGIN_SCREEN';
const REGISTER_SCREEN = 'REGISTER_SCREEN';
const VERIFY_PASSWORD_SCREEN = 'VERIFY_PASSWORD_SCREEN';
const RESET_PASSWORD = 'RESET_PASSWORD';
const INTRODUCTION_PAGE = 'INTRODUCTION_PAGE';
const SHOP_INFO = 'SHOP_INFO';
const BANK_PHOTO = 'BANK_PHOTO';
const ORDER_SCREEN = 'ORDER_SCREEN';
