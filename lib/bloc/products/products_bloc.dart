import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/models/AdminProduct/admin_product.dart';
import 'package:service_products_business/services/product/product_service.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsState());

  List<AdminColorType> list = [];
  List<AdminProduct> listProduct = [];

  List imageList = [];

  ProductService _productService = ProductService();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is OnSelectCategory) {
      print('OnSelectCategory');
      yield _mapOnSelectCategory(event, state);
    } else if (event is OnSelectSubcategory) {
      print('OnSelectSubcategory');
      yield _mapOnSelectSubcategory(event, state);
    } else if (event is OnNameChanged) {
      yield state.copyWith(productName: event.name);
    } else if (event is OnDescriptionChange) {
      yield state.copyWith(description: event.description);
    } else if (event is OnStockType) {
      print('OnStockType');
      yield state.copyWith(stocktype: event.stockType);
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

      print(state.adminStock[0].adminColorType);
    } else if (event is OnAdminStock) {
      yield _mapOnAdminStock(event, state);
    } else if (event is OnAddAdminStock) {
      yield _mapOnAddAdminStock(event, state);
      print(state.adminStock);
    } else if (event is OnDeleteAdminStock) {
      yield _mapOnDeleteAdminStock(event, state);
    } else if (event is OnAddProductImage) {
      yield await _mapOnAddProductImage(event, state);
      print(state.productImage);
    } else if (event is OnProductImageChange) {
    } else if (event is OnDeleteProductImage) {
      yield _mapOnDeleteProductImage(event, state);
    } else if (event is OnHandleCreateProduct) {
      //TODO: SEND DATA TO BACKEND
      // print(state.productName);
      // print(state.description);
      // Map data = {"category": state.category, "subcategory": state.subCategory};
      // // print(state.category);
      // // print(state.subCategory);
      // print('productCategory : $data');
      // print(state.stocktype);

      // List list = state.adminStock.map((e) => e.toJson()).toList();
      // print(list);
      // print(state.priceType);
      // Map priceData = {
      //   "normalPrice": state.normalPrice,
      //   "offertPrice": state.offerPrice
      // };
      // print(priceData);

      // print(state.productImage);
      yield await _mapHandleCreateProduct(event, state);
    }
  }

  Future<ProductsState> _mapHandleCreateProduct(
      OnHandleCreateProduct event, ProductsState state) async {
    Map productCategory = {
      "category": state.category,
      "subcategory": state.subCategory
    };
    List stock = state.adminStock.map((e) => e.toJson()).toList();
    Map price = {
      "normalPrice": state.normalPrice,
      "offertPrice": state.offerPrice
    };
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
        state.productImage);
    if (resp) {
      return state.copyWith(isProductCreated: true);
    } else {
      return state.copyWith(isProductCreated: false);
    }
  }

  ProductsState _mapOnDeleteProductImage(
      OnDeleteProductImage event, ProductsState state) {
    //   listProduct = [...state.adminStock];
    // listProduct.removeAt(event.index);
    // return state.copyWith(adminStock: listProduct);
    imageList = [...state.productImage];
    imageList.removeAt(event.index);
    return state.copyWith(productImage: imageList);
  }

  Future<ProductsState> _mapOnAddProductImage(
      OnAddProductImage event, ProductsState state) async {
    imageList = [...state.productImage];
    final profilePicker = ImagePicker();
    final picketFile =
        await profilePicker.getImage(source: ImageSource.gallery);
    if (picketFile != null) {
      Map data = {"product": picketFile.path};

      imageList.add(data);
      return state.copyWith(productImage: imageList);
    } else {
      return state.copyWith(productImage: state.productImage);
    }
  }

  ProductsState _mapOnAdminStock(OnAdminStock event, ProductsState state) {
    List<AdminProduct> admin = [...state.adminStock];
    admin[event.index].stock.value = TextEditingValue(
        text: event.stock,
        selection: TextSelection.fromPosition(
            TextPosition(offset: event.stock.length)));
    print(admin[event.index].stock);
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
    print('OnaddAdminStock');

    listProduct = [...state.adminStock];
    listProduct.add(event.adminProduct);

    return state.copyWith(adminStock: listProduct);
  }

  ProductsState _mapOnAdminColorStock(
      OnAdminColorStock event, ProductsState state) {
    // AdminProduct product;
    List<AdminProduct> admin = [...state.adminStock];
    admin[event.index].adminColorType = event.adminColorType;

    return state.copyWith(adminStock: admin);
    // admin[event.index].adminColorType = event.adminColorType;
    // return state.copyWith()
  }

  ProductsState _mapOnSelectCategory(
      OnSelectCategory event, ProductsState state) {
    return state.copyWith(category: event.productCategory);
  }

  ProductsState _mapOnSelectSubcategory(
      OnSelectSubcategory event, ProductsState state) {
    return state.copyWith(subCategory: event.productSubCategory);
  }
}
