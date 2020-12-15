part of 'products_bloc.dart';

enum IsProductCreated { UNDEFINED, SUCCESS, FAIL, LOADING }
enum IsProductDeleted { UNDEFINED, SUCCESS, FAIL }
enum IsProductEdited { UNDEFINED, SUCCESS, FAIL }

class ProductsState {
  ProductsState(
      {this.isProductEdited = IsProductEdited.UNDEFINED,
      this.isProductDeleted = IsProductDeleted.UNDEFINED,
      this.filesProduct = const [],
      this.showProducts = ProductCategory.UNDEFINED,
      this.productResponse,
      this.isProductCreated = IsProductCreated.UNDEFINED,
      List<AdminProduct> adminStock,
      this.adminColorType,
      this.adminStockType = AdminStockType.ADMIN_STOCK_UNIQUE,
      this.priceType = PriceType.NORMAL,
      this.normalPrice,
      this.offerPrice,
      this.productName,
      this.description,
      this.stocktype = StockType.UNIQUE,
      this.category,
      this.subCategory,
      this.productImage = const []})
      : this.adminStock = (adminStock == null)
            ? [
                AdminProduct(
                    adminColorType: AdminColorType.YELLOW,
                    sizeProduct: [
                      SizeProduct(
                          size: Sizes.S,
                          sizeStock: TextEditingController(text: ''))
                    ])
              ]
            : adminStock;

  final IsProductDeleted isProductDeleted;
  final IsProductEdited isProductEdited;
  final String productName;
  final String description;
  final ProductCategory category;
  final ProductSubCategory subCategory;
  final IsProductCreated isProductCreated;
  final AdminStockType adminStockType;
  final List productImage;
  final StockType stocktype;
  final PriceType priceType;
  final String normalPrice;
  final String offerPrice;
  final List<AdminProduct> adminStock;
  final AdminColorType adminColorType;
  final ProductCategory showProducts;
  final ProductResponse productResponse;
  final List<File> filesProduct;

  ProductsState copyWith(
      {IsProductEdited isProductEdited,
      IsProductDeleted isProductDeleted,
      ProductCategory showProducts,
      ProductResponse productResponse,
      List<File> filesProduct,
      IsProductCreated isProductCreated,
      List<AdminColorType> adminColorType,
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
        isProductEdited: isProductEdited ?? this.isProductEdited,
        isProductDeleted: isProductDeleted ?? this.isProductDeleted,
        filesProduct: filesProduct ?? this.filesProduct,
        productResponse: productResponse ?? this.productResponse,
        showProducts: showProducts ?? this.showProducts,
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
        adminColorType,
        adminStock,
        isProductCreated
      ];
}
