import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebAdminMainPage extends StatefulWidget {
  const WebAdminMainPage({super.key});

  @override
  State<WebAdminMainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WebAdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Management'),
      ),
      sideBar: SideBar(items: [
        AdminMenuItem(title: 'Dashboard', icon: Icons.dashboard, route: '/'),
        AdminMenuItem(
            title: 'Vendors', icon: CupertinoIcons.person_3, route: '/'),
        AdminMenuItem(
            title: 'Withdrawal', icon: CupertinoIcons.money_dollar, route: '/'),
        AdminMenuItem(
            title: 'Orders', icon: CupertinoIcons.shopping_cart, route: '/'),
        AdminMenuItem(title: 'Categories', icon: Icons.category, route: '/'),
        AdminMenuItem(title: 'Products', icon: Icons.shop, route: '/'),
        AdminMenuItem(
            title: 'Upload Banners', icon: CupertinoIcons.add, route: '/'),
      ], selectedRoute: ''),
      body: Text('Dashboard'),
    );
  }
}
