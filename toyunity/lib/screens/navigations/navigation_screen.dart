import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/screens/producer/add_products/add_product_screen.dart';

import '../../constants/constants.dart';
import 'navigation_content.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({Key? key, required this.screen}) : super(key: key);
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: NavigationContent(
                currentPage: screen,
              ),
            )
          ],
        ),
      )),
    );
  }
}
