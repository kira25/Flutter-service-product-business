import 'package:flutter/material.dart';
import 'package:service_products_business/helpers/enums.dart';

Size handleAdminProductSizeToValue(String text) {
  switch (text) {
    case 'S':
      return Size.S;

      break;
    case 'M':
      return Size.M;

      break;
    case 'L':
      return Size.L;

      break;
    case 'XL':
      return Size.XL;

      break;
    case 'XXL':
      return Size.XXL;

      break;
    default:
      return Size.S;
  }
}

String handleAdminProductSize(Size size) {
  switch (size) {
    case Size.S:
      return 'S';

      break;
    case Size.M:
      return 'M';

      break;
    case Size.L:
      return 'L';

      break;
    case Size.XL:
      return 'XL';

      break;
    case Size.XXL:
      return 'XXL';

      break;
    default:
      return 'Tallas';
  }
}

String handleStockType(StockType stockType) {
  switch (stockType) {
    case StockType.UNIQUE:
      return 'Unico';

      break;
    case StockType.BY_COLOR:
      return 'Por Color';

      break;
    case StockType.BY_SIZE:
      return 'Por Talla';

      break;
    case StockType.BY_COLOR_SIZE:
      return 'Por Color y talla';

      break;
    default:
      return 'Unico';
  }
}

String handleAdminStockType(AdminStockType adminStockType) {
  switch (adminStockType) {
    case AdminStockType.ADMIN_STOCK_UNIQUE:
      return 'Unico';

      break;
    case AdminStockType.ADMIN_STOCK_COLOR:
      return 'Administrar por color';

      break;
    case AdminStockType.ADMIN_STOCK_BY_SIZE:
      return 'Administrar por talla';

      break;
    case AdminStockType.ADMIN_STOCK_BY_COLOR_SIZE:
      return 'Administrar por color y talla';

      break;
    default:
      return 'Unico';
  }
}

String handleProductCategory(ProductCategory productCategory) {
  switch (productCategory) {
    case ProductCategory.HEALTH:
      return 'Salud';

      break;
    case ProductCategory.HOME:
      return 'Hogar';

      break;
    case ProductCategory.KID:
      return 'Infantil';

      break;
    case ProductCategory.MAN:
      return 'Hombre';

      break;
    case ProductCategory.WOMEN:
      return 'Mujer';

      break;
    case ProductCategory.RESTAURANT:
      return 'Restaurantes';

      break;
    case ProductCategory.TECHNOLOGY:
      return 'Tecnologia';

      break;
    case ProductCategory.PET:
      return 'Mascotas';

      break;
    default:
      return '';
  }
}

String handleProductSubcategory(ProductSubCategory productSubCategory) {
  switch (productSubCategory) {
    case ProductSubCategory.BATHROOM:
      return 'Baño';

      break;
    case ProductSubCategory.KITCHEN:
      return 'Cocina';

      break;
    case ProductSubCategory.DECORATION:
      return 'Decoración';

      break;
    case ProductSubCategory.ELECTRONIC_HOME:
      return 'Electrohogar';

      break;
    case ProductSubCategory.WOMEN:
      return 'Mujer';

      break;
    case ProductSubCategory.FURNITURE:
      return 'Muebles';

      break;
    case ProductSubCategory.PLANT:
      return 'Plantas';

      break;

    default:
      return '';
  }
}

String handleAdminColorStock(AdminColorType adminColorType) {
  switch (adminColorType) {
    case AdminColorType.BLACK:
      return 'Negro';

      break;
    case AdminColorType.BLUE:
      return 'Azul';

      break;
    case AdminColorType.GREY:
      return 'Gris';

      break;
    case AdminColorType.YELLOW:
      return 'Amarillo';

      break;
    case AdminColorType.PINK:
      return 'Rosado';

      break;
    case AdminColorType.RED:
      return 'Rojo';

      break;

    default:
      return 'Color';
  }
}

String handlePriceType(PriceType priceType) {
  switch (priceType) {
    case PriceType.NORMAL:
      return 'Normal';

      break;
    case PriceType.OFFERT:
      return 'Oferta';

      break;

    default:
      return '';
  }
}
