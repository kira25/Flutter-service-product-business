import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_products_business/bloc/products/products_bloc.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/models/AdminProduct/admin_product.dart';
import 'package:service_products_business/models/product_response.dart';
import 'package:service_products_business/services/product/product_service.dart';

class EditProductController extends GetxController {
  var uniqueStockController = TextEditingController().obs;
  var stockType = StockType.UNDEFINED.obs;
  var adminStockType = AdminStockType.UNDEFINED.obs;

  var priceType = PriceType.UNDEFINED.obs;
  var normalPrice = TextEditingController().obs;
  var offerPrice = TextEditingController().obs;
  var adminStock = [
    AdminProduct(adminColorType: AdminColorType.YELLOW, sizeProduct: [
      SizeProduct(size: Sizes.S, sizeStock: TextEditingController(text: ''))
    ])
  ].obs;

  FocusNode fquantity;
  FocusNode fnormalprice;
  FocusNode fofferprice;
  List<AdminProduct> admin = [];
  @override
  void onInit() {
    super.onInit();

    fquantity = FocusNode();
    fnormalprice = FocusNode();
    fofferprice = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    fquantity.dispose();
    fnormalprice.dispose();
    fofferprice.dispose();
  }

  var isProductEdited = IsProductEdited.UNDEFINED.obs;

  ProductService productService = ProductService();

  onDeletAdminSizeByStock(int index) {
    admin = [...adminStock];
    admin[0].sizeProduct.removeAt(index);
    adminStock.assignAll(admin);
  }

  onDeleteAdminSizeProduct(int index, int indexProduct) {
    admin = [...adminStock];

    admin[index].sizeProduct.removeAt(indexProduct);
    adminStock.assignAll(admin);
  }

  onAdminSizeProductStock(String sizeStock, int index, int indexproduct) {
    admin = [...adminStock];
    admin[index].sizeProduct[indexproduct].sizeStock.value = TextEditingValue(
        text: sizeStock,
        selection:
            TextSelection.fromPosition(TextPosition(offset: sizeStock.length)));
    adminStock.assignAll(admin);
  }

  onAdminSizeProduct(int index, Sizes newsize, int indexproduct) {
    admin = [...adminStock];
    admin[index].sizeProduct[indexproduct].size = newsize;
    adminStock.assignAll(admin);
  }

  onAdminColorStock(int index, AdminColorType color) {
    admin = [...adminStock];
    admin[index].adminColorType = color;
    adminStock.assignAll(admin);
    print(adminStock[index].adminColorType);
  }

  onAddAdminStock(AdminProduct adminProduct) {
    adminStock.add(adminProduct);
  }

  onAddOnylSize(SizeProduct sizeProduct) {
    admin = [...adminStock];

    admin[0].sizeProduct.add(sizeProduct);
    adminStock.assignAll(admin);
  }

  onAdminStock(int index, String stock) {
    adminStock[index].stock.value = TextEditingValue(
        text: stock,
        selection:
            TextSelection.fromPosition(TextPosition(offset: stock.length)));
    print(adminStock[index].stock.value.text);
  }

  onAddSizeProduct(int index, SizeProduct sizeProduct) {
    admin = [...adminStock];

    admin[index].sizeProduct.add(sizeProduct);
    adminStock.assignAll(admin);
  }

  onAdminBySizeStock(String text, int index) {
    adminStock[0].sizeProduct[index].sizeStock.value = TextEditingValue(
        text: text,
        selection:
            TextSelection.fromPosition(TextPosition(offset: text.length)));
  }

  onAdminSize(int index, Sizes newsize) {
    admin = [...adminStock];
    admin[0].sizeProduct[index].size = newsize;
    adminStock.assignAll(admin);
  }

  onDeleteAdminStock(int index) {
    adminStock.removeAt(index);
  }

  setDataToEdit(
      StockType newStock,
      AdminStockType newAdminStock,
      PriceType newPricetype,
      String newNormalPrice,
      String newOfferPrice,
      List<Stock> stock) {
    print('setdatatoedit');
    stockType.value = newStock;
    adminStockType.value = newAdminStock;
    priceType.value = newPricetype;
    normalPrice.value.value = TextEditingValue(
      text: newNormalPrice,
    );
    offerPrice.value.value = newOfferPrice == null || newOfferPrice == "null"
        ? TextEditingValue(text: "")
        : TextEditingValue(
            text: newOfferPrice,
          );
    if (newStock == StockType.UNIQUE) {
      uniqueStockController.value =
          TextEditingController(text: stock[0].quantity.toString());
    }
  }

  setAdminStock(List<AdminProduct> list) {
    // adminStock.addAll(list);
    adminStock.assignAll(list);
    print(adminStock);
  }

  setAdminProduct(int index, String value) {
    adminStock[index].stock.value = TextEditingValue(
        text: value,
        selection:
            TextSelection.fromPosition(TextPosition(offset: value.length)));
    print(adminStock[index].stock.value.text);
  }

  setStockType(StockType value) {
    stockType.value = value;
    print(stockType.value);
  }

  setAdminStockType(AdminStockType admin) {
    adminStockType.value = admin;
    print(adminStockType.value);
  }

  setPriceType(PriceType price) {
    priceType.value = price;
    print(priceType.value);
  }

  setnormalPrice(String price) {
    normalPrice.value.value = TextEditingValue(
        text: price,
        selection:
            TextSelection.fromPosition(TextPosition(offset: price.length)));
    print(normalPrice.value);
  }

  setofferPrice(String price) {
    offerPrice.value.value = TextEditingValue(
        text: price,
        selection:
            TextSelection.fromPosition(TextPosition(offset: price.length)));
    print(offerPrice.value);
  }

  cleanProductData() {}

  updateProduct(String id, StockType stockType, List<AdminProduct> adminStock,
      int priceType, String normalPrice, String offerPrice) async {
    List stock = [];

    if (stockType == StockType.UNIQUE) {
      stock = adminStock.map((e) => e.toJsonUnique()).toList();
    }

    if (stockType == StockType.BY_COLOR) {
      stock = adminStock.map((e) => e.toJsonColor()).toList();
      print(stock);
    }
    if (stockType == StockType.BY_COLOR_SIZE) {
      stock = adminStock.map((e) => e.toJsonSizeColor()).toList();
    }

    if (stockType == StockType.BY_SIZE) {
      stock = adminStock.map((e) => e.toJsonSize()).toList();
    }

    final resp = await productService.updateProduct(
        id, stockType.index, stock, priceType, normalPrice, offerPrice);
    if (resp) {
      return true;
    } else {
      return false;
    }
  }
}
