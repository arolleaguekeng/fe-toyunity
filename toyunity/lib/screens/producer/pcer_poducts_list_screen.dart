import 'package:toyunity/main.dart';
import 'package:toyunity/screens/home/most_popular/most_popular_screen.dart';
import 'package:toyunity/screens/producer/add_products/add_product_screen.dart';
import 'package:toyunity/screens/producer/products_list.dart';
import 'package:toyunity/screens/producer/showCardDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/constants.dart';

class PcProductListScreen extends StatelessWidget {
  User? user;
  PcProductListScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: custumAppBar(
        title: 'Special Popular',
        action: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              width: appPadding * 0.7,
            ),
            Expanded(
              flex: 5,
              child: PcProductListContent(),
            ),
            SizedBox(
              width: appPadding * 0.7,
            )
          ],
        ),
      ),
      floatingActionButton: Container(
          padding: EdgeInsets.all(appPadding * 0.5),
          decoration: const ShapeDecoration(
            color: primaryColor,
            shape: CircleBorder(),
          ),
          child: IconButton(
              onPressed: () {
                this.user = MyApp.auth.currentUser;
                print(
                    "********************************************************");
                //print(user!.phoneNumber);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddProductScreen()));
              },
              icon: const Icon(
                Icons.add_rounded,
                color: white,
              ))),
    );
  }
}
