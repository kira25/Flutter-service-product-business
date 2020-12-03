part of 'products_bloc.dart';

abstract class ProductsEvent {}

class OnNameChanged extends ProductsEvent {
  final String name;

  OnNameChanged(this.name);
}

class OnDescriptionChange extends ProductsEvent {
  final String description;

  OnDescriptionChange(this.description);
}

class OnSelectCategory extends ProductsEvent {
  final ProductCategory productCategory;

  OnSelectCategory(this.productCategory);
}

class OnSelectSubcategory extends ProductsEvent {
  final ProductSubCategory productSubCategory;

  OnSelectSubcategory(this.productSubCategory);
}

class OnPriceTypeChange extends ProductsEvent {
  final PriceType priceType;

  OnPriceTypeChange(this.priceType);
}

class OnNormalPriceChange extends ProductsEvent {
  final String normalPrice;

  OnNormalPriceChange(this.normalPrice);
}

class OnOfferPriceChange extends ProductsEvent {
  final String offerPrice;

  OnOfferPriceChange(this.offerPrice);
}



////ADD Products
class OnStockType extends ProductsEvent {
  final StockType stockType;

  OnStockType(this.stockType);
}

class OnAdminStockType extends ProductsEvent {
  final AdminStockType adminStockType;

  OnAdminStockType(this.adminStockType);
}
///////

//ADMIN STOCK
class OnAdminColorStock extends ProductsEvent {
  final AdminColorType adminColorType;
  final int index;

  OnAdminColorStock(this.adminColorType, this.index);
}

class OnAdminStock extends ProductsEvent {
  final String stock;
  final int index;

  OnAdminStock(this.stock, this.index);
}

class OnAddAdminStock extends ProductsEvent {
  final AdminProduct adminProduct;
  final int index;

  OnAddAdminStock({this.adminProduct, this.index});
}

class OnDeleteAdminStock extends ProductsEvent {
  final int index;

  OnDeleteAdminStock(this.index);
}

//IMAGE PRODUCT
class OnProductImageChange extends ProductsEvent {
  Map productImage;
  final int index;

  OnProductImageChange(this.productImage, this.index);
}

class OnAddProductImage extends ProductsEvent{
 
}

class OnDeleteProductImage extends ProductsEvent{
  final int index;

  OnDeleteProductImage(this.index);
}




//HANDLE CREATE PRODUCT

class OnHandleCreateProduct extends ProductsEvent {}
