part of 'orders_services_bloc.dart';

 class OrdersServicesState extends Equatable {
  final bool showPending;
  final bool showDone;
  final bool showCancel;
  const OrdersServicesState(
      {this.showPending = true,
      this.showDone = false,
      this.showCancel = false});


OrdersServicesState copyWith({
    bool showPending,
    bool showDone,
    bool showCancel,
   
  }) {
    return OrdersServicesState(
        showPending: showPending ?? this.showPending,
        showDone: showDone ?? this.showDone,
        showCancel: showCancel ?? this.showCancel,
        );
  }

  @override
  List<Object> get props => [showCancel,showDone,showPending];
}

