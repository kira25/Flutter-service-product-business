part of 'shop_bloc.dart';

class ShopState extends Equatable {
  ShopState(
      {this.description = const Description.pure(),
      this.state = const State.pure(),
      this.address = const Address.pure(),
      this.whatsapp = const Whatsapp.pure(),
      this.facebook = const Facebook.pure(),
      this.instagram = const Instagram.pure(),
      this.bankAccount = const BankAccount.dirty(),
      this.interbankAccount = const InterbankAccount.pure(),
      this.shopStatus = FormzStatus.pure,
      this.failShop = false,
      this.deliveryTime = '1 hrs'});

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
  final bool failShop;

  ShopState copyWith(
      {Description description,
      State state,
      Address address,
      Whatsapp whatsapp,
      Facebook facebook,
      Instagram instagram,
      BankAccount bankAccount,
      InterbankAccount interbankAccount,
      FormzStatus shopStatus,
      String deliveryTime,
      bool failShop}) {
    return ShopState(
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
        failShop: failShop ?? this.failShop);
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
        deliveryTime
      ];
}
