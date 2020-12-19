import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_products_business/helpers/enums.dart';
import 'package:service_products_business/models/service_response.dart';
import 'package:service_products_business/services/services/services_service.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  ServicesBloc() : super(ServicesState());
  List<File> filesImage = [];

  ServicesService _servicesService = ServicesService();

  @override
  Stream<ServicesState> mapEventToState(
    ServicesEvent event,
  ) async* {
    if (event is OnAvailableType) {
      yield state.copyWith(availableType: event.availableType);

      print(state.availableType);
    } else if (event is OnDepartmentType) {
      yield state.copyWith(departmentType: event.departmentType);
      print(state.departmentType);
    } else if (event is OnProvinceType) {
      yield state.copyWith(provinceType: event.provinceType);
      print(state.provinceType);
    } else if (event is OnDistrictType) {
      yield state.copyWith(districtType: event.districtType);
      print(state.districtType);
    } else if (event is OnAddressChange) {
      yield state.copyWith(address: event.address);
      print(state.address);
    } else if (event is OnDistrictAvailable) {
      yield state.copyWith(districtAvailable: event.list);

      List list =
          state.districtAvailable.map((e) => {"district": e.index}).toList();
      print(list);
    } else if (event is OnNormalPriceChange) {
      yield state.copyWith(normalPrice: event.normalPrice);
      print(state.normalPrice);
    } else if (event is OnOfferPriceChange) {
      yield state.copyWith(offerPrice: event.offerPrice);
      print(state.offerPrice);
    } else if (event is OnPriceType) {
      yield state.copyWith(priceType: event.priceType);
      print(state.priceType);
    } else if (event is OnServiceNameChange) {
      yield state.copyWith(serviceName: event.name);
      print(state.serviceName);
    } else if (event is OnServiceDescriptionChange) {
      yield state.copyWith(description: event.description);
      print(state.description);
    } else if (event is OnAttentionHours) {
      yield state.copyWith(attentionHours: event.attentionHours);
      print(state.attentionHours);
    } else if (event is OnServiceDeliveryTime) {
      yield state.copyWith(deliveryTime: event.deliveryTime);
      print(state.deliveryTime);
    } else if (event is OnCleanServiceData) {
      yield _mapOnCleanServiceData(event, state);
    } else if (event is OnHandleServiceCreate) {
      yield* _mapOnHandleServiceCreate(event, state);
    } else if (event is OnAddServiceImage) {
      yield await _mapOnAddImageService(event, state);
      print(state.filesService);
    } else if (event is OnDeleteServiceImage) {
      yield _mapOnDeleteImageService(event, state);
    } else if (event is OnLoadShopServices) {
      yield await _mapOnLoadShopServices(event, state);
    } else if (event is OnDeleteService) {
      yield* _mapOnDeleteService(event, state);
    }
  }

  Stream<ServicesState> _mapOnDeleteService(
      OnDeleteService event, ServicesState state) async* {
    final resp = await _servicesService.deleteService(event.id);
    if (resp) {
      yield state.copyWith(isServiceDeleted: IsServiceDeleted.SUCCESS);
      yield state.copyWith(isServiceDeleted: IsServiceDeleted.UNDEFINED);
    } else {
      yield state.copyWith(isServiceDeleted: IsServiceDeleted.FAIL);
      yield state.copyWith(isServiceDeleted: IsServiceDeleted.UNDEFINED);
    }
  }

  Future<ServicesState> _mapOnLoadShopServices(
      OnLoadShopServices event, ServicesState state) async {
    print('OnLoadShopServices');
    final resp = await _servicesService.getServiceByUser();
    if (resp[0]) {
      return state.copyWith(serviceResponse: resp[1], isServices: true);
    } else {
      return state.copyWith(
          serviceResponse: ServiceResponse(), isServices: false);
    }
  }

  Stream<ServicesState> _mapOnHandleServiceCreate(
      OnHandleServiceCreate event, ServicesState state) async* {
    yield state.copyWith(isServiceCreated: IsServiceCreated.LOADING);
    List list = [];
    if (state.districtAvailable.isNotEmpty) {
      list = state.districtAvailable.map((e) => {"district": e.index}).toList();
    }

    final resp = await _servicesService.createService(
        state.serviceName,
        state.description,
        state.deliveryTime,
        state.attentionHours,
        state.availableType,
        state.departmentType,
        state.provinceType,
        state.districtType,
        state.address,
        list,
        state.priceType,
        state.normalPrice,
        state.offerPrice,
        state.filesService);
    if (resp == true) {
      yield state.copyWith(isServiceCreated: IsServiceCreated.SUCCESS);
    } else {
      yield state.copyWith(isServiceCreated: IsServiceCreated.FAIL);
    }
  }

  ServicesState _mapOnDeleteImageService(
      OnDeleteServiceImage event, ServicesState state) {
    filesImage = [...state.filesService];
    filesImage.removeAt(event.index);
    return state.copyWith(filesService: filesImage);
  }

  Future<ServicesState> _mapOnAddImageService(
      OnAddServiceImage event, ServicesState state) async {
    filesImage = [...state.filesService];
    final profilePicker = ImagePicker();
    final picketFile =
        await profilePicker.getImage(source: ImageSource.gallery);

    if (picketFile != null) {
      filesImage.add(File(picketFile.path));
      return state.copyWith(filesService: filesImage);
    } else {
      return state.copyWith(filesService: state.filesService);
    }
  }

  ServicesState _mapOnCleanServiceData(
      OnCleanServiceData event, ServicesState state) {
    print('OnCleanServiceData');
    return state.copyWith(
        serviceName: null,
        description: null,
        deliveryTime: null,
        attentionHours: null,
        availableType: AvailableType.SHOP,
        departmentType: DepartmentType.UNDEFINED,
        provinceType: ProvinceType.UNDEFINED,
        districtType: DistrictType.UNDEFINED,
        address: null,
        districtAvailable: [],
        priceType: PriceType.NORMAL,
        normalPrice: null,
        offerPrice: null,
        filesService: []);
  }
}
