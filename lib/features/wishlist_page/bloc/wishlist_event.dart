part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class RemoveFromWishListEvent extends WishlistEvent {
  final ProductDataModel productDataModel;

  RemoveFromWishListEvent({required this.productDataModel});
}

class AddItemFromWishlistToCartEvent extends WishlistEvent {
  final ProductDataModel productDataModel;

  AddItemFromWishlistToCartEvent({required this.productDataModel});
}