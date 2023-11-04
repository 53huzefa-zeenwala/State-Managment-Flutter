part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}

class HomeProductWishlistButtonClickEvent extends HomeEvent {}

class HomeProductCartButtonClickEvent extends HomeEvent {}

class HomeWishlistButtonNavigationEvent extends HomeEvent {}

class HomeCartButtonNavigationEvent extends HomeEvent {}
// think of event