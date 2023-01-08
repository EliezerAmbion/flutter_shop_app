import 'package:flutter/material.dart';
// you need to import this to use the provider
import 'package:provider/provider.dart';

import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';
import 'screens/cart_screen.dart';

import 'providers/cart.dart';
import 'providers/products_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider allows us to register a class to which you can then listen in child widgets.
    // And whenever that class updates the widgets which are listening (child widgets here) will rebuild.

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // The builder (create:) method will receive a context,
          // and it will return a new instance of your provider class, in this case,
          // the ProductsProvider class.

          // NOTE: alternatively, you can use ChangeNotifierProvider.value if you DON'T need the context
          // and change the create: to value:
          // ex: value: ProductsProvider(), Notice that there is NO context and NO arrow function.
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        )
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
            primary: Colors.deepPurple,
            secondary: Colors.deepOrange,
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: const TextStyle(
                  color: Colors.white,
                ),
              ),
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
