import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/cart_items.dart';
import '../../home/models/home_product_data_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<RemoveFromCartEvent>(removeFromCartEvent);
    on<AddProductToCartFromCartEvent>(addProductToCartFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    print('adddd');
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> removeFromCartEvent(
      RemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItems));
  }

  addProductToCartFromCartEvent(
      AddProductToCartFromCartEvent event, Emitter<CartState> emit) {
    cartItems.add(event.productDataModel);
    emit(CartSuccessState(cartItems: cartItems));
  }
}
