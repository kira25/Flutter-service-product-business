import 'package:flutter/material.dart';
import 'package:service_products_business/pages/AddProducts/add_products_page.dart';
import 'package:service_products_business/pages/AddServices/add_services_page.dart';
import 'package:service_products_business/pages/Bank&Photo/bank_photo_page.dart';
import 'package:service_products_business/pages/Category/category_page.dart';
import 'package:service_products_business/pages/Department/department_page.dart';
import 'package:service_products_business/pages/District/district_page.dart';
import 'package:service_products_business/pages/EditProduct/edit_product_page.dart';
import 'package:service_products_business/pages/EditServices/edit_services_page.dart';
import 'package:service_products_business/pages/Introduction/introduction_page.dart';
import 'package:service_products_business/pages/Main/main_page.dart';
import 'package:service_products_business/pages/Province/province_page.dart';
import 'package:service_products_business/pages/ResetPassword/reset_password_page.dart';
import 'package:service_products_business/pages/ShopInfo/ShopInfo.dart';
import 'package:service_products_business/pages/Splash/splash_page.dart';
import 'package:service_products_business/pages/Login/login_page.dart';
import 'package:service_products_business/pages/Register/register_page.dart';
import 'package:service_products_business/pages/Subcategory/subcategory_page.dart';
import 'package:service_products_business/pages/VerifyPasswordPin/verify_password_pin_page.dart';
import 'package:service_products_business/pages/test.dart';

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
  ADD_PRODUCTS_PAGE: (_) => AddProductsPage(),
  CATEGORY_PAGE: (_) => CategoryPage(),
  SUBCATEGORY_PAGE: (_) => SubcategoryPage(),
  TEST: (_) => TestPage(),
  EDIT_PRODUCT_PAGE: (_) => EditProductPage(),
  DEPARTMENT_PAGE: (_) => DepartmentPage(),
  PROVINCE_PAGE: (_) => ProvincePage(),
  DISTRICT_PAGE: (_) => DistrictPage(),
  ADD_SERVICES_PAGE :(_)=>AddServicesPage(),
  EDIT_SERVICES_PAGE : (_)=>EditServicesPage()
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
const TEST = 'TEST';
const EDIT_PRODUCT_PAGE = 'EDIT_PRODUCT_PAGE';
const DEPARTMENT_PAGE = 'DEPARTMENT_PAGE';
const PROVINCE_PAGE = 'PROVINCE_PAGE';
const DISTRICT_PAGE = 'DISTRICT_PAGE';
const ADD_SERVICES_PAGE = 'ADD_SERVICES_PAGE';
const EDIT_SERVICES_PAGE = 'EDIT_SERVICES_PAGE';