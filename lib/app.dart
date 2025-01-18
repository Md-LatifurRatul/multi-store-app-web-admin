import 'package:ecom_multi_store_web_admin/views/screens/web_admin_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WebAdminApp extends StatelessWidget {
  const WebAdminApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin-Panel',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const WebAdminMainPage(),
      builder: EasyLoading.init(),
    );
  }
}
