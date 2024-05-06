part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {
  final List<ProductDataModel> products = GroceryData.groceryItems
      .map((e) => ProductDataModel(
            id: e['id'],
            name: e['name'],
            description: e['description'],
            img: e['img'],
            price: e['price'],
            oldPrice: e['oldPrice'],
          ))
      .toList();
}

class NavigateToWishListPageActionState extends HomeActionState {}

class NavigateToCartPageActionState extends HomeActionState {}

class ItemWishListedActionState extends HomeActionState {}

class ItemRemovedFromWishlistActionState extends HomeActionState {}

class ItemCartedActionState extends HomeActionState {}

class ItemRemovedFromCartActionState extends HomeActionState {}
