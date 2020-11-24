part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {}

class DescriptionChange extends ShopEvent {
  final String description;

  DescriptionChange({this.description});

  @override
  List<Object> get props => [description];
}

class StateChange extends ShopEvent {
  final String state;

  StateChange(this.state);

  @override
  List<Object> get props => [state];
}

class DeliveryChange extends ShopEvent {
  final String deliveryTime;

  DeliveryChange(this.deliveryTime);

  @override
  // TODO: implement props
  List<Object> get props => [deliveryTime];
}

class AddressChange extends ShopEvent {
  final String address;

  AddressChange(this.address);

  @override
  List<Object> get props => [address];
}

class WhatsappChange extends ShopEvent {
  final String whatsapp;

  WhatsappChange(this.whatsapp);

  @override
  List<Object> get props => [whatsapp];
}

class FacebookChange extends ShopEvent {
  final String facebook;

  FacebookChange(this.facebook);

  @override
  List<Object> get props => [facebook];
}

class InstagramChange extends ShopEvent {
  final String instagram;

  InstagramChange(this.instagram);

  @override
  List<Object> get props => [instagram];
}

class BankAccountChange extends ShopEvent {
  final String bankAccount;

  BankAccountChange(this.bankAccount);

  @override
  List<Object> get props => [bankAccount];
}

class InterbankAccountChange extends ShopEvent {
  final String interbankAccount;

  InterbankAccountChange(this.interbankAccount);

  @override
  List<Object> get props => [interbankAccount];
}

class ShopSubmitted extends ShopEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
