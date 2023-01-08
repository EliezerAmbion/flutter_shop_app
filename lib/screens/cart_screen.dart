import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// show keyword is to let flutter know that you are only interested in Cart class inside this file
import '../providers/cart.dart' show Cart;
import '../widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart,'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      'P${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.headline6!.color),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text(
                      'Order Now!',
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, i) => CartCard(
              id: cart.items.values.toList()[i].id,
              price: cart.items.values.toList()[i].price,
              quantity: cart.items.values.toList()[i].quantity,
              title: cart.items.values.toList()[i].title,
            ),
            itemCount: cart.itemCount,
          ))
        ],
      ),
    );
  }
}
