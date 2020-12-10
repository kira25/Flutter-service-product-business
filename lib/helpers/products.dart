import 'package:service_products_business/helpers/enums.dart';


Sizes handleResponseToSize ( int size){
  switch(size){
    case 0:
      return Sizes.S;
      break;
    case 1:
      return Sizes.M;
      break;
    case 2:
      return Sizes.L;
      break;
    case 3:
      return Sizes.XL;
      break;
    case 4:
      return Sizes.XXL;
      break;
    default:
      return Sizes.S;
  }
}

StockType handleIntToStockType(int stock) {
  switch (stock) {
    case 0:
      return StockType.UNIQUE;

      break;
    case 1:
      return StockType.BY_COLOR;

      break;
    case 2:
      return StockType.BY_SIZE;

      break;
    case 3:
      return StockType.BY_COLOR_SIZE;

      break;

    default:
      return StockType.UNIQUE;
  }
}

Sizes handleAdminProductSizeToValue(String text) {
  switch (text) {
    case 'S':
      return Sizes.S;

      break;
    case 'M':
      return Sizes.M;

      break;
    case 'L':
      return Sizes.L;

      break;
    case 'XL':
      return Sizes.XL;

      break;
    case 'XXL':
      return Sizes.XXL;

      break;
    default:
      return Sizes.S;
  }
}

String handleAdminProductSize(Sizes size) {
  switch (size) {
    case Sizes.S:
      return 'S';

      break;
    case Sizes.M:
      return 'M';

      break;
    case Sizes.L:
      return 'L';

      break;
    case Sizes.XL:
      return 'XL';

      break;
    case Sizes.XXL:
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

String handleProductCategoryFromResponse(int productCategory) {
  switch (productCategory) {
    case 0:
      return 'Hogar';

      break;
    case 1:
      return 'Hombre';

      break;
    case 2:
      return 'Infantil';

      break;
    case 3:
      return 'Mascotas';

      break;
    case 4:
      return 'Mujer';

      break;
    case 5:
      return 'Restaurantes';

      break;
    case 6:
      return 'Salud';

      break;
    case 7:
      return 'Tecnologia';

      break;
    default:
      return 'Categoria';
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
      return 'Categoria';
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
      return 'Subcategoria';
  }
}

AdminColorType handleIntToAdminColorType( int value){
   switch (value) {
    case 0:
      return AdminColorType.YELLOW;

      break;
    case 1:
      return AdminColorType.BLUE;

      break;
    case 2:
      return AdminColorType.GREY;

      break;
    case 3:
      return AdminColorType.BLACK;

      break;
    case 4:
      return AdminColorType.RED;

      break;
    case 5:
      return AdminColorType.PINK;

      break;

    default:
      return AdminColorType.YELLOW;
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

PriceType handleIntToPriceType(int price) {
  switch (price) {
    case 0:
      return PriceType.NORMAL;

      break;
    case 1:
      return PriceType.OFFERT;

      break;

    default:
      return PriceType.NORMAL;
  }
}
