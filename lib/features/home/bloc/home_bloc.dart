import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_grocery/data/grocery_items.dart';

import '../models/home_product_data_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeWishListButtonClickedEvent>(homeWishListButtonClickedEvent);
    on<HomeCartButtonClickedEvent>(homeCartButtonClickedEvent);
  }


  FutureOr<void> homeInitialEvent(HomeInitialEvent event,
      Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedState(products: GroceryData.groceryItems.map((e) =>
        ProductDataModel(id:e['id'],
            name: e['name'],
            description: e['description'],
            img: e['img'],
            price: e['price'])).toList()));
  }

  FutureOr<void> homeWishListButtonNavigateEvent(
      HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(HomeCartButtonNavigateEvent event,
      Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeWishListButtonClickedEvent(
      HomeWishListButtonClickedEvent event, Emitter<HomeState> emit) {
    print('WishList Button Clicked');
  }

  FutureOr<void> homeCartButtonClickedEvent(HomeCartButtonClickedEvent event,
      Emitter<HomeState> emit) {
    print('WishList Button Clicked');
  }

}
