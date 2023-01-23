import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/edit_product_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';
import 'screens/user_products_screen.dart';

import 'providers/auth.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'providers/products_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            create: (_) => ProductsProvider(null, []),
            update: (context, auth, previousProducts) => ProductsProvider(
              auth.token!,
              previousProducts == null ? [] : previousProducts.items,
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (context) => Orders(null, []),
            update: (context, auth, previousOrders) => Orders(
              auth.token!,
              previousOrders == null ? [] : previousOrders.orders,
            ),
          )
        ],
        child: Consumer<Auth>(
          builder: (context, auth, _) => MaterialApp(
            title: 'MyShop',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.deepPurple,
                secondary: Colors.deepOrange,
              ),
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
              fontFamily: 'Lato',
              appBarTheme: const AppBarTheme(
                // color: Colors.deepPurple,
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                centerTitle: true,
              ),
            ),
            home: auth.isAuth! ? ProductsOverviewScreen() : const AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrdersScreen.routeName: (context) => OrdersScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
            },
          ),
        ));
  }
}
