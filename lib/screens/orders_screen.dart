import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_card.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).getOrders(),
        builder: (context, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dataSnapShot.error != null) {
            return const Center(
              child: Text('An error occured'),
            );
          }

          return Consumer<Orders>(
            builder: (context, orderData, child) => ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) => OrderCard(order: orderData.orders[i]),
            ),
          );
        },
      ),
    );
  }
}
