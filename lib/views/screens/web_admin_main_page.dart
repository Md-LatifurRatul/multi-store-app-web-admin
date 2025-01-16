import 'package:ecom_multi_store_web_admin/views/screens/side_bar_screen/categories_screen.dart';
import 'package:ecom_multi_store_web_admin/views/screens/side_bar_screen/dashboard_screen.dart';
import 'package:ecom_multi_store_web_admin/views/screens/side_bar_screen/orders_screen.dart';
import 'package:ecom_multi_store_web_admin/views/screens/side_bar_screen/products_screen.dart';
import 'package:ecom_multi_store_web_admin/views/screens/side_bar_screen/upload_banner_screen.dart';
import 'package:ecom_multi_store_web_admin/views/screens/side_bar_screen/vendors_screen.dart';
import 'package:ecom_multi_store_web_admin/views/screens/side_bar_screen/withdrawal_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class WebAdminMainPage extends StatefulWidget {
  const WebAdminMainPage({super.key});

  @override
  State<WebAdminMainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WebAdminMainPage> {
  Widget _selectedItem = const DashboardScreen();

  void screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = const DashboardScreen();
        });
        break;
      case VendorsScreen.routeName:
        setState(() {
          _selectedItem = const VendorsScreen();
        });
        break;
      case WithDrawalScreen.routeName:
        setState(() {
          _selectedItem = const WithDrawalScreen();
        });
        break;
      case OrdersScreen.routeName:
        setState(() {
          _selectedItem = const OrdersScreen();
        });
        break;
      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = const CategoriesScreen();
        });
        break;

      case ProductScreen.routeName:
        setState(() {
          _selectedItem = const ProductScreen();
        });
        break;
      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = const UploadBannerScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Management'),
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            route: DashboardScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Vendors',
            icon: CupertinoIcons.person_3,
            route: VendorsScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Withdrawal',
            icon: CupertinoIcons.money_dollar,
            route: WithDrawalScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Orders',
            icon: CupertinoIcons.shopping_cart,
            route: OrdersScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Categories',
            icon: Icons.category,
            route: CategoriesScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Products',
            icon: Icons.shop,
            route: ProductScreen.routeName,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            icon: CupertinoIcons.add,
            route: UploadBannerScreen.routeName,
          ),
        ],
        selectedRoute: '',
        onSelected: (item) {
          screenSelector(item);
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'Vendor Store Panel',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              '@copyright store',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _selectedItem,
    );
  }
}
