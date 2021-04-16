import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_products_business/models/shop/bankaccount.dart';
import 'package:service_products_business/models/shop/interbankaccount.dart';
import 'package:service_products_business/models/shop/shop_models.dart';
import 'package:service_products_business/models/shop_response.dart';
import 'package:service_products_business/services/shop/shop_service.dart';

part 'shop_event.dart';

part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopState());

  ShopService _shopService = ShopService();

  List<File> filesImage = [];

  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    if (event is DescriptionChange) {
      yield _mapDescriptionChange(event, state);
    } else if (event is StateChange) {
      yield _mapStateChange(event, state);
    } else if (event is AddressChange) {
      yield _mapAddressChange(event, state);
    } else if (event is WhatsappChange) {
      yield _mapWhatsappChange(event, state);
    } else if (event is FacebookChange) {
      yield _mapFacebookChange(event, state);
    } else if (event is InstagramChange) {
      yield _mapInstagramChange(event, state);
    } else if (event is BankAccountChange) {
      yield _mapBankAccountChange(event, state);
    } else if (event is InterbankAccountChange) {
      yield _mapInterbankAccountChange(event, state);
    } else if (event is ShopSubmitted) {
      yield* _mapShopSubmitted(event, state);
    } else if (event is DeliveryChange) {
      yield _mapDeliveryChange(event, state);
    } else if (event is OnProfilePhoto) {
      yield await _mapOnProfilePhoto(event, state);
    } else if (event is OnProfileTitle) {
      yield await _mapOnProfileTitle(event, state);
    } else if (event is OnRemoveProfilePhoto) {
      yield _mapOnRemoveProfilePhoto(event, state);
      print(state.profilePhoto);
    } else if (event is OnRemoveProfileTitle) {
      //REMOVE PROFILE TITLE
      yield _mapOnRemoveProfileTitle(event, state);
    } else if (event is OnLoadShopData) {
      yield state.copyWith(shopResponse: event.shopResponse);
    } else if (event is OnTabIndexChange) {
      yield state.copyWith(tabindex: event.index);
    } else if (event is OnCleanShopData) {
      yield state.copyWith(profilePhoto: null);
    }
  }

  void mapOnLoadShopData() async {
    print('OnLoadShopData');
    final resp = await _shopService.getShopInfo();
    print(resp[1].ok);
    if (resp[0]) {
      add(OnLoadShopData(shopResponse: resp[1]));
    } else {
      add(OnLoadShopData(shopResponse: null));
    }
  }

//PROFILE TITLE PHOTO
  ShopState _mapOnRemoveProfileTitle(
      OnRemoveProfileTitle event, ShopState state) {
    print('OnRemoveProfileTitle');
    filesImage = [...state.listImages];
    filesImage[1] = null;
    print(filesImage);

    return state.copyWith(imageList: filesImage);
  }

  Future<ShopState> _mapOnProfileTitle(
      OnProfileTitle event, ShopState state) async {
    filesImage = [...state.listImages];
    final profilePicker = ImagePicker();
    final picketFile =
        await profilePicker.getImage(source: ImageSource.gallery);
    if (picketFile.path == null)
      return state.copyWith(profilePhoto: null, imageList: state.listImages);
    filesImage[1] = File(picketFile.path);
    if (picketFile != null) {
      return state.copyWith(
          profileTitle: File(picketFile.path), imageList: filesImage);
    } else {
      return state.copyWith(profileTitle: null, imageList: state.listImages);
    }
  }

//PROFILE PHOTO
  ShopState _mapOnRemoveProfilePhoto(
      OnRemoveProfilePhoto event, ShopState state) {
    print('OnRemoveProfilePhoto');
    filesImage = [...state.listImages];
    filesImage[0] = null;
    print(filesImage);

    return state.copyWith(imageList: filesImage);
  }

  Future<ShopState> _mapOnProfilePhoto(
      OnProfilePhoto event, ShopState state) async {
    filesImage = [...state.listImages];
    final profilePicker = ImagePicker();
    final picketFile =
        await profilePicker.getImage(source: ImageSource.gallery);
    print("profile_photo : ${picketFile.path}");
    if (picketFile.path == null)
      return state.copyWith(imageList: state.listImages);

    filesImage[0] = File(picketFile.path);

    if (picketFile != null) {
      return state.copyWith(imageList: filesImage);
    } else {
      return state.copyWith(imageList: state.listImages);
    }
  }

//DELIVERY
  ShopState _mapDeliveryChange(DeliveryChange event, ShopState state) {
    print('DeliveryChange');
    return state.copyWith(deliveryTime: event.deliveryTime);
  }

  ShopState _mapDescriptionChange(DescriptionChange event, ShopState state) {
    final description = Description.dirty(event.description);
    return state.copyWith(
        description: description, shopStatus: Formz.validate([description]));
  }

  ShopState _mapStateChange(StateChange event, ShopState state) {
    final location = State.dirty(event.state);
    return state.copyWith(
        state: location, shopStatus: Formz.validate([location]));
  }

  ShopState _mapAddressChange(AddressChange event, ShopState state) {
    final address = Address.dirty(event.address);
    return state.copyWith(
        address: address, shopStatus: Formz.validate([address]));
  }

  ShopState _mapWhatsappChange(WhatsappChange event, ShopState state) {
    final whatsapp = Whatsapp.dirty(event.whatsapp);
    return state.copyWith(
        whatsapp: whatsapp, shopStatus: Formz.validate([whatsapp]));
  }

  ShopState _mapFacebookChange(FacebookChange event, ShopState state) {
    final facebook = Facebook.dirty(event.facebook);

    return state.copyWith(
        facebook: facebook, shopStatus: Formz.validate([facebook]));
  }

  ShopState _mapInstagramChange(InstagramChange event, ShopState state) {
    final instagram = Instagram.dirty(event.instagram);
    return state.copyWith(
        instagram: instagram, shopStatus: Formz.validate([instagram]));
  }

  ShopState _mapBankAccountChange(BankAccountChange event, ShopState state) {
    final bankAccount = BankAccount.dirty(event.bankAccount);
    return state.copyWith(
        bankAccount: bankAccount, shopStatus: Formz.validate([bankAccount]));
  }

  ShopState _mapInterbankAccountChange(
      InterbankAccountChange event, ShopState state) {
    final interbankAccount = InterbankAccount.dirty(event.interbankAccount);
    return state.copyWith(
        interbankAccount: interbankAccount,
        shopStatus: Formz.validate([interbankAccount]));
  }

  Stream<ShopState> _mapShopSubmitted(
      ShopSubmitted event, ShopState state) async* {
    print('ShopSubmitted');
    if (state.shopStatus.isValid) {
      yield state.copyWith(shopStatus: FormzStatus.submissionInProgress);
    }
    try {
      final resp = await _shopService.createShop(
          state.description.value,
          state.state.value,
          state.address.value,
          state.deliveryTime,
          state.whatsapp.value,
          state.facebook.value,
          state.instagram.value,
          state.bankAccount.value,
          state.interbankAccount.value,
          "",
          "");

      final update = await _shopService.updateShop(
          state.listImages[0], state.listImages[1]);

      print(resp);
      print(update);
      if (resp && update) {
        yield state.copyWith(shopStatus: FormzStatus.submissionSuccess);
      } else {
        yield state.copyWith(shopStatus: FormzStatus.submissionFailure);
      }
    } catch (e) {
      print('error : $e');
      yield state.copyWith(failShop: true);
      print(state.failShop);
    }
  }
}
