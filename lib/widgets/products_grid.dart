import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // notice that the type is ProductsProvider
    // We're telling the provider package that we want to establish a direct communication channel to the provided instance
    // of the ProductsProvider class.
    // And now the prodiver package looks at the parent of ProductsGrid, which is the ProductsOverviewScreen
    // then the provider will see that the ProductsOverviewScreen doesn't have a provider, so it goes
    // to the parent of the ProductsOverviewScreen, which is the MyApp widget(Main.dart)
    // then it will see a provider(ChangeNotifierProvider).
    // NOTE: the <ProductsProvider> should be the same in the builder method in the MyApp widget(Main.dart)
    // i.e create: (context) => ProductsProvider(), see Main.dart file.
    final productsData = Provider.of<ProductsProvider>(context);

    // the .items is a getter in ProductsProvider
    final products = productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, i) => ProductItem(
        id: products[i].id,
        title: products[i].title,
        imageUrl: products[i].imageUrl,
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
