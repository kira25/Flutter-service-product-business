part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();
  
  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}
