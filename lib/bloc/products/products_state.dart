part of 'products_bloc.dart';

class ProductsState extends Equatable {
  ProductsState(
      {this.isProductCreated = false,
      List<AdminProduct> adminStock,
      this.adminColorType,
      this.stock,
      this.adminStockType,
      this.priceType,
      this.normalPrice,
      this.offerPrice,
      this.productName,
      this.description,
      this.stocktype,
      this.category,
      this.subCategory,
      this.productImage = const []})
      : this.adminStock = (adminStock == null) ? [AdminProduct()] : adminStock;

  final String productName;
  final String description;
  final ProductCategory category;
  final ProductSubCategory subCategory;
  final bool isProductCreated;
  final AdminStockType adminStockType;
  final List productImage;
  final StockType stocktype;
  final PriceType priceType;
  final String normalPrice;
  final String offerPrice;
  final List<AdminProduct> adminStock;
  final AdminColorType adminColorType;
  final String stock;

  ProductsState copyWith(
      {bool isProductCreated,
      List<AdminColorType> adminColorType,
      String stock,
      String productName,
      String description,
      ProductCategory category,
      ProductSubCategory subCategory,
      AdminStockType adminStockType,
      List productImage,
      StockType stocktype,
      PriceType priceType,
      String normalPrice,
      String offerPrice,
      List<AdminProduct> adminStock}) {
    return ProductsState(
        adminStockType: adminStockType ?? this.adminStockType,
        productImage: productImage ?? this.productImage,
        category: category ?? this.category,
        subCategory: subCategory ?? this.subCategory,
        description: description ?? this.description,
        normalPrice: normalPrice ?? this.normalPrice,
        offerPrice: offerPrice ?? this.offerPrice,
        priceType: priceType ?? this.priceType,
        productName: productName ?? this.productName,
        stocktype: stocktype ?? this.stocktype,
        adminColorType: adminColorType ?? this.adminColorType,
        stock: stock ?? this.stock,
        adminStock: adminStock ?? this.adminStock,
        isProductCreated: isProductCreated ?? this.isProductCreated);
  }

  @override
  List<Object> get props => [
        adminStockType,
        subCategory,
        category,
        stocktype,
        priceType,
        description,
        productImage,
        productName,
        normalPrice,
        offerPrice,
        adminStock,
        adminColorType,
        stock,
        adminStock,
        isProductCreated
      ];
}
