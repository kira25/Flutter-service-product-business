part of 'orders_products_bloc.dart';

class OrdersProductsState extends Equatable {
  final bool showPending;
  final bool showFollowing;
  final bool showCompleted;
  final bool showRejected;

  const OrdersProductsState(
      {this.showPending = true,
      this.showFollowing = false,
      this.showCompleted = false,
      this.showRejected = false});

  OrdersProductsState copyWith({
    bool showPending,
    bool showFollowing,
    bool showCompleted,
    bool showRejected,
  }) {
    return OrdersProductsState(
        showCompleted: showCompleted ?? this.showCompleted,
        showFollowing: showFollowing ?? this.showFollowing,
        showPending: showPending ?? this.showPending,
        showRejected: showRejected ?? this.showRejected);
  }

  @override
  List<Object> get props =>
      [showCompleted, showFollowing, showPending, showRejected];
}
