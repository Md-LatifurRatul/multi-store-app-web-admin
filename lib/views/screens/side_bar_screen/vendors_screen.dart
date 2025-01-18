import 'package:ecom_multi_store_web_admin/views/screens/widgets/row_header_widget.dart';
import 'package:flutter/material.dart';

class VendorsScreen extends StatelessWidget {
  const VendorsScreen({super.key});
  static const String routeName = '\VendorsScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Manage Vendors',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaderWidget(
                text: 'LOGO',
                flex: 1,
              ),
              RowHeaderWidget(text: 'BUSSENESS NAME', flex: 3),
              RowHeaderWidget(text: 'CITY', flex: 2),
              RowHeaderWidget(text: 'STATE', flex: 2),
              RowHeaderWidget(text: 'ACTION', flex: 1),
              RowHeaderWidget(text: 'VIEW MORE', flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
