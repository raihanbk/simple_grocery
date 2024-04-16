import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_grocery/data/cart_items.dart';

import '../../../data/wishlist_item.dart';
import '../../home/models/home_product_data_model.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<RemoveFromWishListEvent>(removeFromWishlistEvent);
    on<AddItemFromWishlistToCartEvent>(addItemFromWishlistToCartEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> removeFromWishlistEvent(
      RemoveFromWishListEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.productDataModel);
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> addItemFromWishlistToCartEvent(
      AddItemFromWishlistToCartEvent event, Emitter<WishlistState> emit) {
    cartItems.add(event.productDataModel);
    emit(ItemAddedToCartActionState());
    wishlistItems.remove(event.productDataModel);
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }
}
