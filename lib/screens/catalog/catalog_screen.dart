
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../blocs/product/product_bloc.dart';
import '../../core/constants.dart';
import '../../models/models.dart';
import '../../widgets/widget.dart';

class CatalogScreen extends StatelessWidget {
  final Category category;

  const CatalogScreen({Key? key, required this.category}) : super(key: key);
  static const String routeName = '/catalog';

  static Route route({required category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => CatalogScreen(category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(
              child: CircularProgressIndicator(color:kMainColor),
            );
          }
          if (state is ProductLoaded) {
            final List<Product> categoryProducts = state.products
                .where((product) => product.category == category.name)
                .toList();

            return GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.15,
              ),
              itemCount: categoryProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: ProductCard.catalog(
                    product: categoryProducts[index],
                  ),
                );
              },
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}