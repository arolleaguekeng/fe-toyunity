import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'orders_content.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              flex: 5,
              child: OrderContent(),
            )
          ],
        ),
      ),
    );
  }
}
