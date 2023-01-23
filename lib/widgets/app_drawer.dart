import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget _buildListTile(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'Hello, Friend!',
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            toolbarHeight: 50,
          ),
          const Divider(),
          _buildListTile(
            context,
            Icons.shop,
            'Shop',
            '/',
          ),
          const Divider(),
          _buildListTile(
            context,
            Icons.payment,
            'Orders',
            OrdersScreen.routeName,
          ),
          const Divider(),
          _buildListTile(
            context,
            Icons.edit,
            'Manage Products',
            UserProductsScreen.routeName,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
