import 'package:ecom_multi_store_web_admin/views/screens/widgets/row_header_widget.dart';
import 'package:flutter/material.dart';

class WithDrawalScreen extends StatelessWidget {
  const WithDrawalScreen({super.key});
  static const String routeName = '\WithDrawalScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'WithDrawal',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            children: [
              RowHeaderWidget(text: 'NAME', flex: 1),
              RowHeaderWidget(text: 'AMOUNT', flex: 3),
              RowHeaderWidget(text: 'BANK NAME', flex: 2),
              RowHeaderWidget(text: 'BANK ACCOUNT', flex: 2),
              RowHeaderWidget(text: 'EMAIL', flex: 1),
              RowHeaderWidget(text: 'PHONE', flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
