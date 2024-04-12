part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeWishListButtonClickedEvent extends HomeEvent {

}

class HomeCartButtonClickedEvent extends HomeEvent {

}

class HomeWishListButtonNavigateEvent extends HomeEvent {

}

class HomeCartButtonNavigateEvent extends HomeEvent {

}