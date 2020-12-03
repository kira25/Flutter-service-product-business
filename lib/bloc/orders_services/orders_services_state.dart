part of 'orders_services_bloc.dart';

abstract class OrdersServicesState extends Equatable {
  const OrdersServicesState();
  
  @override
  List<Object> get props => [];
}

class OrdersServicesInitial extends OrdersServicesState {}
