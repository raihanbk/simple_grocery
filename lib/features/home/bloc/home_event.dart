part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class InitialEvent extends HomeEvent {}

class NavigateToWishListPageEvent extends HomeEvent {}

class NavigateToCartPageEvent extends HomeEvent {}

class WishListButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  WishListButtonClickedEvent({required this.clickedProduct});
}

class CartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  CartButtonClickedEvent({required this.clickedProduct});
}