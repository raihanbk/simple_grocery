part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {
  final List<ProductDataModel> products;
  LoadedState({required this.products});
}

class NavigateToWishListPageActionState extends HomeActionState {}

class NavigateToCartPageActionState extends HomeActionState {}

class ItemWishListedActionState extends HomeActionState {}

class ItemCartedActionState extends HomeActionState {}