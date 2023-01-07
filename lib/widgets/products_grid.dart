import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import 'product_card.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  const ProductsGrid({
    super.key,
    required this.showFavorites,
  });

  @override
  Widget build(BuildContext context) {
    // notice that the type is ProductsProvider (<ProductsProvider>)
    // We're telling the provider package that we want to establish a
    // direct communication channel to the provided instance of the ProductsProvider class.

    // Using Provider.of<ProductsProvider>, the provider package will BUBBLE UP the widget tree
    // until it see a provider(ChangeNotifierProvider) which is in the MyApp widget(Main.dart)

    // NOTE: the <ProductsProvider> should be the same in the builder method
    // in the MyApp widget(Main.dart)
    // i.e create: (context) => ProductsProvider(), see Main.dart file.
    final productsData = Provider.of<ProductsProvider>(context);

    // the .favoriteItems and .items are getter in ProductsProvider
    final products =
        showFavorites ? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductCard(
            // id: products[i].id,
            // title: products[i].title,
            // imageUrl: products[i].imageUrl,
            ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
