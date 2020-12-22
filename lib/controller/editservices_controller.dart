import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/services/services/services_service.dart';

class EditServicesController extends GetxController {
  var name = "".obs;
  var deliveryTime = TextEditingController().obs;
  var attentionHours = TextEditingController().obs;
  var availableType = AvailableType.UNDEFINED.obs;
  var departmentType = DepartmentType.UNDEFINED.obs;
  var provinceType = ProvinceType.UNDEFINED.obs;
  var districtType = DistrictType.UNDEFINED.obs;
  var address = TextEditingController().obs;
  var priceType = PriceType.UNDEFINED.obs;
  var districtAvailable = List<DistrictType>();
  var normalPrice = TextEditingController().obs;
  var offerPrice = TextEditingController().obs;

  List get districts => districtAvailable;

  FocusNode fdelivery;
  FocusNode fattention;
  FocusNode faddress;
  FocusNode fnormalprice;
  FocusNode fofferprice;

  ServicesService service = ServicesService();

  @override
  void onInit() {
    super.onInit();

    fdelivery = FocusNode();
    fattention = FocusNode();
    faddress = FocusNode();
    fnormalprice = FocusNode();
    fofferprice = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    fdelivery.dispose();
    fattention.dispose();
    faddress.dispose();
    fnormalprice.dispose();
    fofferprice.dispose();
  }

  onDistrictAvailable(List<DistrictType> list) {
    districtAvailable = list;
    update();
    print('controller districtavaiable : $districtAvailable');
  }

  onDistrictType(DistrictType value) {
    districtType.value = value;
    print(districtType.value);
  }

  onProvinceType(ProvinceType province) {
    provinceType.value = province;
    print(provinceType.value);
  }

  onDepartmentType(DepartmentType department) {
    departmentType.value = department;
    print(departmentType.value);
  }

  onPriceType(PriceType value) {
    priceType.value = value;
    print(priceType.value);
  }

  onOfferPrice(String value) {
    offerPrice.value.value = TextEditingValue(
        text: value,
        selection:
            TextSelection.fromPosition(TextPosition(offset: value.length)));
    print(offerPrice.value.value);
  }

  onNormalPrice(String value) {
    normalPrice.value.value = TextEditingValue(
        text: value,
        selection:
            TextSelection.fromPosition(TextPosition(offset: value.length)));
    print(normalPrice.value.value);
  }

  onAddressChange(String value) {
    address.value.value = TextEditingValue(
        text: value,
        selection:
            TextSelection.fromPosition(TextPosition(offset: value.length)));
  }

  onLoadServiceDataToEdit(
    String newname,
    String delivery,
    String attention,
    AvailableType available,
    DepartmentType department,
    ProvinceType province,
    DistrictType district,
    String newaddress,
    PriceType price,
    List<DistrictType> list,
    String normalprice,
    String offerprice,
  ) {
    name.value = newname;
    deliveryTime.value.value = TextEditingValue(text: delivery);
    attentionHours.value.value = TextEditingValue(text: attention);
    availableType.value = available;
    departmentType.value = department;
    provinceType.value = province;
    districtType.value = district;
    address.value.value = TextEditingValue(text: newaddress);
    priceType.value = price;
    districtAvailable = list;
    normalPrice.value.value = TextEditingValue(text: normalprice);
    offerPrice.value.value = offerprice == null || offerprice == "null"
        ? TextEditingValue(text: "")
        : TextEditingValue(
            text: offerprice,
          );
    print('setdataservices to edit');
    print(name.value);
    print(departmentType.value);
    print(provinceType.value);
    print(districtType.value);
    print(availableType.value);
    update();
  }

  onServiceDeliveryTime(String value) {
    deliveryTime.value.value = TextEditingValue(
        text: value,
        selection:
            TextSelection.fromPosition(TextPosition(offset: value.length)));
    print(deliveryTime.value);
  }

  onAttentionHours(String value) {
    attentionHours.value.value = TextEditingValue(
        text: value,
        selection:
            TextSelection.fromPosition(TextPosition(offset: value.length)));
    print(attentionHours.value);
  }

  onAvailableType(AvailableType available) {
    availableType.value = available;
    print(availableType.value);
  }

  onUpdateServices(
      String deliveryTime,
      String attentionHours,
      AvailableType availableType,
      DepartmentType departmentType,
      ProvinceType provinceType,
      DistrictType districtType,
      String address,
      List districtAvailables,
      PriceType priceType,
      String normalPrice,
      String offerPrice,
      String id) async{
    List list = [];

    if (districtAvailable.isNotEmpty) {
      list = districtAvailable.map((e) => {"district": e.index}).toList();
    }
    final resp = await service.updateService(
        deliveryTime,
        attentionHours,
        availableType,
        departmentType,
        provinceType,
        districtType,
        address,
        list,
        priceType,
        normalPrice,
        offerPrice,
        id);
    if(resp){
      return true;
    }else{
      return false;
    }
  }
}
