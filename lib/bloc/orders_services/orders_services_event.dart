part of 'orders_services_bloc.dart';

abstract class OrdersServicesEvent extends Equatable {
  const OrdersServicesEvent();

  @override
  List<Object> get props => [];
}

class OnServicePending extends OrdersServicesEvent {}

class OnServiceDone extends OrdersServicesEvent {}

class OnServiceCancel extends OrdersServicesEvent {}


