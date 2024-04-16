import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_grocery/data/cart_items.dart';
import 'package:simple_grocery/data/grocery_items.dart';
import 'package:simple_grocery/data/wishlist_item.dart';

import '../models/home_product_data_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitialEvent>(initialEvent);
    on<NavigateToWishListPageEvent>(navigateToWishListPageEvent);
    on<NavigateToCartPageEvent>(navigateToCartPageEvent);
    on<WishListButtonClickedEvent>(wishListButtonClickedEvent);
    on<CartButtonClickedEvent>(cartButtonClickedEvent);
  }

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<HomeState> emit) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(LoadedState(
        products: GroceryData.groceryItems
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                img: e['img'],
                price: e['price']))
            .toList()));
  }

  FutureOr<void> navigateToWishListPageEvent(
      NavigateToWishListPageEvent event, Emitter<HomeState> emit) {
    emit(NavigateToWishListPageActionState());
  }

  FutureOr<void> navigateToCartPageEvent(
      NavigateToCartPageEvent event, Emitter<HomeState> emit) {
    emit(NavigateToCartPageActionState());
  }

  FutureOr<void> wishListButtonClickedEvent(
      WishListButtonClickedEvent event, Emitter<HomeState> emit) {
    wishlistItems.add(event.clickedProduct);
    emit(ItemWishListedActionState());
  }

  FutureOr<void> cartButtonClickedEvent(
      CartButtonClickedEvent event, Emitter<HomeState> emit) {
    cartItems.add(event.clickedProduct);
    emit(ItemCartedActionState());
  }
}
