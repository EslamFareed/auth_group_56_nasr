part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


class LoadingProductsState extends HomeState{}
class ErrorProductsState extends HomeState{}
class SuccessProductsState extends HomeState{}


class SearchState extends HomeState{}