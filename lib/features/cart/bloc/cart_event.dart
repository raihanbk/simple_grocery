part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {
}

class RemoveFromCartEvent extends CartEvent {
  final ProductDataModel productDataModel;

  RemoveFromCartEvent({required this.productDataModel});
}
class AddProductToCartFromCartEvent extends CartEvent {
  final ProductDataModel productDataModel;

  AddProductToCartFromCartEvent({required this.productDataModel});
}
