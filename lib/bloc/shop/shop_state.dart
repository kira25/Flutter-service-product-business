part of 'shop_bloc.dart';

class ShopState extends Equatable {
  ShopState(
      {List<File> imageList,
      this.tabindex = 0,
      this.description = const Description.pure(),
      this.state = const State.pure(),
      this.address = const Address.pure(),
      this.whatsapp = const Whatsapp.pure(),
      this.facebook = const Facebook.pure(),
      this.instagram = const Instagram.pure(),
      this.bankAccount = const BankAccount.pure(),
      this.interbankAccount = const InterbankAccount.pure(),
      this.shopStatus = FormzStatus.pure,
      this.failShop = false,
      this.deliveryTime = '1 hrs',
      this.profilePhoto,
      this.profileTitle,
      this.shopResponse})
      : this.listImages = (imageList == null) ? new List(2) : imageList;

  final int tabindex;
  final Description description;
  final State state;
  final String deliveryTime;
  final Address address;
  final Whatsapp whatsapp;
  final Facebook facebook;
  final Instagram instagram;
  final BankAccount bankAccount;
  final InterbankAccount interbankAccount;
  final FormzStatus shopStatus;
  final File profilePhoto;
  final File profileTitle;
  final List<File> listImages;
  final bool failShop;
  final ShopResponse shopResponse;

  ShopState copyWith(
      {List<File> imageList,
      int tabindex,
      Description description,
      State state,
      Address address,
      Whatsapp whatsapp,
      Facebook facebook,
      Instagram instagram,
      BankAccount bankAccount,
      InterbankAccount interbankAccount,
      FormzStatus shopStatus,
      String deliveryTime,
      bool failShop,
      File profilePhoto,
      File profileTitle,
      ShopResponse shopResponse}) {
    return ShopState(
        imageList: imageList ?? this.listImages,
        tabindex: tabindex ?? this.tabindex,
        description: description ?? this.description,
        state: state ?? this.state,
        address: address ?? this.address,
        whatsapp: whatsapp ?? this.whatsapp,
        instagram: instagram ?? this.instagram,
        bankAccount: bankAccount ?? this.bankAccount,
        interbankAccount: interbankAccount ?? this.interbankAccount,
        shopStatus: shopStatus ?? this.shopStatus,
        deliveryTime: deliveryTime ?? this.deliveryTime,
        facebook: facebook ?? this.facebook,
        failShop: failShop ?? this.failShop,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        profileTitle: profileTitle ?? this.profileTitle,
        shopResponse: shopResponse ?? this.shopResponse);
  }

  @override
  List<Object> get props => [
        description,
        state,
        address,
        whatsapp,
        facebook,
        instagram,
        bankAccount,
        interbankAccount,
        shopStatus,
        deliveryTime,
        shopResponse,
        tabindex,
        listImages
      ];
}
