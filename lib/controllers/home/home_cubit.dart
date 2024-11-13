import 'package:auth_group_56_nasr/models/product_model.dart';
import 'package:auth_group_56_nasr/views/home/home_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<ProductModel> products = [];

  void getProducts() async {
    emit(LoadingProductsState());

    try {
      var response = await Dio().get("https://fakestoreapi.com/products");

      if (response.statusCode == 200) {
        var data = response.data as List;
        products = data.map((e) => ProductModel.fromJson(e)).toList();

        emit(SuccessProductsState());
      } else {
        emit(ErrorProductsState());
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorProductsState());
    }
  }

  List<ProductModel> searchProducts = [];

  void search(String text) {
    searchProducts = products
        .where(
          (e) =>
              e.title!.toLowerCase().contains(text.toLowerCase()) ||
              e.category!.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();

    emit(SearchState());
  }
}
