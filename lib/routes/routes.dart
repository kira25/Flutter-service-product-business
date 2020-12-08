import 'package:flutter/material.dart';
import 'package:service_products_business/pages/AddProducts/add_products_page.dart';
import 'package:service_products_business/pages/Bank&Photo/bank_photo_page.dart';
import 'package:service_products_business/pages/Category/category_page.dart';
import 'package:service_products_business/pages/Introduction/introduction_page.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/pages/ResetPassword/reset_password_page.dart';
import 'package:service_products_business/pages/ShopInfo/ShopInfo.dart';
import 'package:service_products_business/pages/Splash/splash_page.dart';
import 'package:service_products_business/pages/Login/login_page.dart';
import 'package:service_products_business/pages/Register/register_page.dart';
import 'package:service_products_business/pages/Subcategory/subcategory_page.dart';
import 'package:service_products_business/pages/VerifyPasswordPin/verify_password_pin_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  SPLASH_PAGE: (_) => SplashPage(),
  LOGIN_PAGE: (_) => LoginPage(),
  REGISTER_PAGE: (_) => RegisterPage(),
  VERIFY_PASSWORD_PAGE: (_) => VerifyPasswordPinPage(),
  RESET_PASSWORD_PAGE: (_) => ResetPasswordPage(),
  INTRODUCTION_PAGE: (_) => IntroductionPage(),
  SHOP_INFO_PAGE: (_) => ShopInfoPage(),
  BANK_PHOTO_PAGE: (_) => BankPhotoPage(),
  ORDER_PAGE: (_) => MainPage(),
  ADD_PRODUCTS_PAGE: (_) => AddProducts(),
  CATEGORY_PAGE: (_) => CategoryPage(),
  SUBCATEGORY_PAGE: (_) => SubcategoryPage(),
};

const SPLASH_PAGE = 'SPLASH_PAGE';
const LOGIN_PAGE = 'LOGIN_PAGE';
const REGISTER_PAGE = 'REGISTER_PAGE';
const VERIFY_PASSWORD_PAGE = 'VERIFY_PASSWORD_PAGE';
const RESET_PASSWORD_PAGE = 'RESET_PASSWORD_PAGE';
const INTRODUCTION_PAGE = 'INTRODUCTION_PAGE';
const SHOP_INFO_PAGE = 'SHOP_INFO_PAGE';
const BANK_PHOTO_PAGE = 'BANK_PHOTO_PAGE';
const ORDER_PAGE = 'ORDER_PAGE';
const ADD_PRODUCTS_PAGE = 'ADD_PRODUCTS_PAGE';
const CATEGORY_PAGE = 'CATEGORY_PAGE';
const SUBCATEGORY_PAGE = 'SUBCATEGORY_PAGE';
