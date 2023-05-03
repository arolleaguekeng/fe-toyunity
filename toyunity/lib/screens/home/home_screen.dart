import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../producer/add_products/add_product_screen.dart';
import 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              flex: 6,
              child: HomeContent(),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: primaryColor),
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddToyScreen()));
          },
        ),
      ),
    );
  }
}
