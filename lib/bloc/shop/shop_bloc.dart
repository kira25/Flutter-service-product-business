import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial());

  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
