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

class OnStockChange extends ProductsEvent {
  final String stock;
  final int index;

  OnStockChange(this.stock, this.index);
}

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

  OnAddAdminStock({this.adminProduct});
}

class OnDeleteAdminStock extends ProductsEvent {
  final int index;

  OnDeleteAdminStock(this.index);
}

class OnAdminSize extends ProductsEvent {
  final Sizes size;
  final int index;

  OnAdminSize(this.size, this.index);
}

//ADMIN PRODUCT SIZE COLOR
class OnAddSizeProduct extends ProductsEvent {
  final int index;
  final SizeProduct sizeProduct;

  OnAddSizeProduct({this.sizeProduct, this.index});
}

class OnAdminSizeProduct extends ProductsEvent {
  final int index;
  final int indexProduct;
  final Sizes size;

  OnAdminSizeProduct(this.index, this.size, this.indexProduct);
}

class OnAdminSizeProductStock extends ProductsEvent {
  final String sizeStock;
  final int index;
  final int indexProduct;

  OnAdminSizeProductStock(this.sizeStock, this.index, this.indexProduct);
}

class OnDeleteAdminSizeProduct extends ProductsEvent {
  final int indexProduct;
  final int index;

  OnDeleteAdminSizeProduct(this.index, this.indexProduct);
}

class OnAddOnlySize extends ProductsEvent {
  final SizeProduct sizeProduct;

  OnAddOnlySize(this.sizeProduct);
}

class OnAdminBySizeStock extends ProductsEvent {
  final String sizeStock;
  final int index;

  OnAdminBySizeStock(this.sizeStock, this.index);
}

//IMAGE PRODUCT
class OnProductImageChange extends ProductsEvent {
  Map productImage;
  final int index;

  OnProductImageChange(this.productImage, this.index);
}

class OnAddProductImage extends ProductsEvent {}

class OnDeleteProductImage extends ProductsEvent {
  final int index;

  OnDeleteProductImage(this.index);
}

//HANDLE CREATE PRODUCT

class OnHandleCreateProduct extends ProductsEvent {}

class OnCleanProductData extends ProductsEvent {}

class OnLoadShopProducts extends ProductsEvent {}

class OnShowProducts extends ProductsEvent {
  final ProductCategory category;

  OnShowProducts(this.category);
}
