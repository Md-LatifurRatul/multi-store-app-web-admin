import 'package:ecom_multi_store_web_admin/views/screens/widgets/row_header_widget.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  static const String routeName = '\ProductScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Products',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaderWidget(text: 'IMAGE', flex: 1),
              RowHeaderWidget(text: 'NAME', flex: 3),
              RowHeaderWidget(text: 'PRICE', flex: 2),
              RowHeaderWidget(text: 'QUANTITY', flex: 2),
              RowHeaderWidget(text: 'ACTION', flex: 1),
              RowHeaderWidget(text: 'VIEW MORE', flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
