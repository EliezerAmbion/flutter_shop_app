import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/product_model.dart';
import '../providers/cart.dart';

class ProductCard extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductCard({
  //   super.key,
  //   required this.id,
  //   required this.title,
  //   required this.imageUrl,
  // });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // Consumer<Product> is the alternative syntax to Provider.of<Product>
          // You can user Consumer<> if you want to ONLY update a SPECIFIC part, NOT the entire app like the Provider.of.
          // You can use them simultaneously. Like in this example,
          // we have Provider.of<Product> above
          // we have Cosumer<Product> below.

          // NOTE: use Provier.of if you want to rebuild everything
          // use Consumer if you want to rebuild a specific part
          leading: Consumer<Product>(
            builder: (BuildContext context, product, Widget? child) =>
                IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
            },
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
