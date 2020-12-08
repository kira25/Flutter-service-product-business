import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/models/AdminProduct/admin_product.dart';
import 'package:service_products_business/models/product_response.dart';
import 'package:service_products_business/services/product/product_service.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsState());

  List<AdminColorType> list = [];
  List<AdminProduct> listProduct = [];

  List imageList = [];
  List<File> filesImage = [];

  ProductService _productService = ProductService();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is OnSelectCategory) {
      yield _mapOnSelectCategory(event, state);
      print(state.category.index);
    } else if (event is OnSelectSubcategory) {
      yield _mapOnSelectSubcategory(event, state);
       print(state.subCategory.index);
    } else if (event is OnNameChanged) {
      yield state.copyWith(productName: event.name);
    } else if (event is OnDescriptionChange) {
      yield state.copyWith(description: event.description);
    } else if (event is OnStockType) {
      yield state.copyWith(stocktype: event.stockType);
    } else if (event is OnStockChange) {
      yield _mapOnStockChange(event, state);
    } else if (event is OnPriceTypeChange) {
      yield state.copyWith(priceType: event.priceType);
    } else if (event is OnNormalPriceChange) {
      yield state.copyWith(normalPrice: event.normalPrice);
    } else if (event is OnOfferPriceChange) {
      yield state.copyWith(offerPrice: event.offerPrice);
    } else if (event is OnProductImageChange) {
      yield state
          .copyWith(productImage: [...state.productImage, event.productImage]);
    } else if (event is OnAdminStockType) {
      yield state.copyWith(adminStockType: event.adminStockType);
    } else if (event is OnAdminColorStock) {
      yield _mapOnAdminColorStock(event, state);
    } else if (event is OnAdminStock) {
      yield _mapOnAdminStock(event, state);
    } else if (event is OnAddAdminStock) {
      yield _mapOnAddAdminStock(event, state);
    } else if (event is OnDeleteAdminStock) {
      yield _mapOnDeleteAdminStock(event, state);
    } else if (event is OnAddProductImage) {
      yield await _mapOnAddProductImage(event, state);
      print(state.filesProduct);
    } else if (event is OnProductImageChange) {
    } else if (event is OnDeleteProductImage) {
      yield _mapOnDeleteProductImage(event, state);
    } else if (event is OnHandleCreateProduct) {
      yield await _mapHandleCreateProduct(event, state);
    } else if (event is OnAddSizeProduct) {
      yield _mapOnAddSizeProduct(event, state);
    } else if (event is OnDeleteAdminSizeProduct) {
      yield _mapOnDeleteAdminSizeProduct(event, state);
    } else if (event is OnAdminSizeProduct) {
      yield _mapOnAdminSizeProduct(event, state);
    } else if (event is OnAdminSizeProductStock) {
      yield _mapOnAdminSizeProductStock(event, state);
    } else if (event is OnAdminSize) {
      yield _mapOnAdminSize(event, state);
    } else if (event is OnCleanProductData) {
      yield state.copyWith(
          adminColorType: null,
          adminStock: [
            AdminProduct(adminColorType: AdminColorType.YELLOW, sizeProduct: [
              SizeProduct(
                  size: Sizes.S, sizeStock: TextEditingController(text: ''))
            ])
          ],
          adminStockType: null,
          category: ProductCategory.UNDEFINED,
          description: null,
          isProductCreated: IsProductCreated.UNDEFINED,
          normalPrice: null,
          offerPrice: null,
          priceType: PriceType.NORMAL,
          productImage: [],
          productName: null,
          stocktype: StockType.UNIQUE,
          subCategory: ProductSubCategory.UNDEFINED,
          filesProduct: []);
    } else if (event is OnLoadShopProducts) {
      yield await _mapOnLoadShopProducts(event, state);
    } else if (event is OnShowProducts) {
      yield state.copyWith(showProducts: event.category);
    } else if (event is OnAddOnlySize) {
      listProduct = [...state.adminStock];
      listProduct[0].sizeProduct.add(event.sizeProduct);

      yield state.copyWith(adminStock: listProduct);
    } else if (event is OnAdminBySizeStock) {
      List<AdminProduct> admin = [...state.adminStock];
      admin[0].sizeProduct[event.index].sizeStock.value = TextEditingValue(
          text: event.sizeStock,
          selection: TextSelection.fromPosition(
              TextPosition(offset: event.sizeStock.length)));

      print(admin[0].toJsonSize());
      yield state.copyWith(adminStock: admin);
    }
  }

  Future<ProductsState> _mapOnLoadShopProducts(
      OnLoadShopProducts event, ProductsState state) async {
    print('OnLoadShopProducts');
    final resp = await _productService.getProductByUser();
    print(resp);
    if (resp[0]) {
      return state.copyWith(
          productResponse: resp[1], showProducts: ProductCategory.HOME);
    } else {
      return state.copyWith(productResponse: null);
    }
  }

  ProductsState _mapOnStockChange(OnStockChange event, ProductsState state) {
    List<AdminProduct> admin = [...state.adminStock];
    admin[event.index].stock.value = TextEditingValue(
        text: event.stock,
        selection: TextSelection.fromPosition(
            TextPosition(offset: event.stock.length)));
    return state.copyWith(adminStock: admin);
  }

  ProductsState _mapOnAdminSize(OnAdminSize event, ProductsState state) {
    List<AdminProduct> admin = [...state.adminStock];
    admin[0].sizeProduct[event.index].size = event.size;
    print(admin[0].sizeProduct[event.index].size);
    return state.copyWith(adminStock: admin);
  }

  //CREATE PRODUCT

  Future<ProductsState> _mapHandleCreateProduct(
      OnHandleCreateProduct event, ProductsState state) async {
    List stock = [];

    if (state.stocktype == StockType.UNIQUE) {
      stock = state.adminStock.map((e) => e.toJsonUnique()).toList();
    }

    if (state.stocktype == StockType.BY_COLOR) {
      stock = state.adminStock.map((e) => e.toJsonColor()).toList();
      print(stock);
    }
    if (state.stocktype == StockType.BY_COLOR_SIZE) {
      stock = state.adminStock.map((e) => e.toJsonSizeColor()).toList();
    }

    if (state.stocktype == StockType.BY_SIZE) {
      stock = state.adminStock.map((e) => e.toJsonSize()).toList();
    }

    final resp = await _productService.createProduct(
        state.productName,
        state.description,
        state.category,
        state.subCategory,
        state.stocktype.index,
        stock,
        state.priceType.index,
        state.normalPrice,
        state.offerPrice,
        state.productImage,
        state.filesProduct);
    if (resp) {
      return state.copyWith(isProductCreated: IsProductCreated.SUCCESS);
    } else {
      return state.copyWith(isProductCreated: IsProductCreated.FAIL);
    }
  }

  //IMAGES

  ProductsState _mapOnDeleteProductImage(
      OnDeleteProductImage event, ProductsState state) {
    imageList = [...state.productImage];
    imageList.removeAt(event.index);
    return state.copyWith(productImage: imageList);
  }

  Future<ProductsState> _mapOnAddProductImage(
      OnAddProductImage event, ProductsState state) async {
    imageList = [...state.productImage];
    filesImage = [...state.filesProduct];
    final profilePicker = ImagePicker();
    final picketFile =
        await profilePicker.getImage(source: ImageSource.gallery);
    if (picketFile != null) {
      Map data = {"product": picketFile.path};

      imageList.add(data);
      print('imagelist added');
      filesImage.add(File(picketFile.path));

      print('filesImage added');
      return state.copyWith(productImage: imageList, filesProduct: filesImage);
    } else {
      return state.copyWith(productImage: state.productImage);
    }
  }

//ADMIN STOCK

  ProductsState _mapOnAddSizeProduct(
      OnAddSizeProduct event, ProductsState state) {
    listProduct = [...state.adminStock];
    listProduct[event.index].sizeProduct.add(event.sizeProduct);

    return state.copyWith(adminStock: listProduct);
  }

  ProductsState _mapOnAdminSizeProduct(
      OnAdminSizeProduct event, ProductsState state) {
    List<AdminProduct> admin = [...state.adminStock];
    admin[event.index].sizeProduct[event.indexProduct].size = event.size;

    return state.copyWith(adminStock: admin);
  }

  ProductsState _mapOnAdminSizeProductStock(
      OnAdminSizeProductStock event, ProductsState state) {
    List<AdminProduct> admin = [...state.adminStock];
    admin[event.index].sizeProduct[event.indexProduct].sizeStock.value =
        TextEditingValue(
            text: event.sizeStock,
            selection: TextSelection.fromPosition(
                TextPosition(offset: event.sizeStock.length)));
    print(admin[event.index].sizeProduct[event.indexProduct].sizeStock..text);
    print(admin[0].toJsonSizeColor());
    return state.copyWith(adminStock: admin);
  }

  ProductsState _mapOnDeleteAdminSizeProduct(
      OnDeleteAdminSizeProduct event, ProductsState state) {
    listProduct = [...state.adminStock];
    listProduct[event.index].sizeProduct.removeAt(event.indexProduct);

    return state.copyWith(adminStock: listProduct);
  }

  ProductsState _mapOnAdminStock(OnAdminStock event, ProductsState state) {
    List<AdminProduct> admin = [...state.adminStock];
    admin[event.index].stock.value = TextEditingValue(
        text: event.stock,
        selection: TextSelection.fromPosition(
            TextPosition(offset: event.stock.length)));

    return state.copyWith(adminStock: admin);
  }

  ProductsState _mapOnDeleteAdminStock(
      OnDeleteAdminStock event, ProductsState state) {
    listProduct = [...state.adminStock];
    listProduct.removeAt(event.index);
    return state.copyWith(adminStock: listProduct);
  }

  ProductsState _mapOnAddAdminStock(
      OnAddAdminStock event, ProductsState state) {
    listProduct = [...state.adminStock];
    listProduct.add(event.adminProduct);

    return state.copyWith(adminStock: listProduct);
  }

  ProductsState _mapOnAdminColorStock(
      OnAdminColorStock event, ProductsState state) {
    // AdminProduct product;
    List<AdminProduct> admin = [...state.adminStock];
    admin[event.index].adminColorType = event.adminColorType;
    print(admin[event.index].adminColorType);
    return state.copyWith(adminStock: admin);
    // admin[event.index].adminColorType = event.adminColorType;
    // return state.copyWith()
  }

//CATEGORY
  ProductsState _mapOnSelectCategory(
      OnSelectCategory event, ProductsState state) {
    return state.copyWith(category: event.productCategory);
  }

  ProductsState _mapOnSelectSubcategory(
      OnSelectSubcategory event, ProductsState state) {
    return state.copyWith(subCategory: event.productSubCategory);
  }
}
