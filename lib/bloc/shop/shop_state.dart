part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();
  
  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}
