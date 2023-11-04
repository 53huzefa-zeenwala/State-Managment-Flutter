part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {}

class HomeLoadedLoadingState extends HomeState {}

class HomeLoadedErrorState extends HomeState {}

class HomeNavigateToWishlistPage extends HomeActionState {}

class HomeNavigateToCartPage extends HomeActionState {}
// some Build Ui And Some take Action

