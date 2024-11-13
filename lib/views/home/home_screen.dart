import 'package:auth_group_56_nasr/controllers/home/home_cubit.dart';
import 'package:auth_group_56_nasr/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    cubit.getProducts();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value) {
                    cubit.search(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Search ....",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  List<ProductModel> products = [];
                  if (state is LoadingProductsState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ErrorProductsState) {
                    return const Center(
                      child: Text("Error, Please try again!!!!"),
                    );
                  } else if (state is SearchState) {
                    products = cubit.searchProducts;
                  } else {
                    products = cubit.products;
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = products[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(item.image ?? ""),
                          ),
                          title: Text(item.title ?? "No Title"),
                          subtitle: Text(
                              "${item.price?.toString() ?? "No Price"} - ${item.category ?? "No Category"}"),
                        ),
                      );
                    },
                    itemCount: products.length,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
