import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/screens/chat/contact_list/contact_content.dart';
import 'package:toyunity/screens/components/component/tabbar_widget.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:flutter/material.dart';

import 'active_content.dart';
import 'complete_content.dart';

class OrderContent extends StatefulWidget {
  const OrderContent({Key? key}) : super(key: key);

  @override
  State<OrderContent> createState() => _OrderContent();
}

class _OrderContent extends State<OrderContent> {
  bool isLoading = true;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        foregroundColor: white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              child: Image.asset('assets/images/png/logo.png'),
            ),
            SizedBox(
              width: appPadding * 0.5,
            ),
            CustumText(
              text: "Opérations",
              size: 25,
              color: Colors.black,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              color: Colors.black,
              icon: Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () {},
              color: Colors.black,
              icon: Icon(Icons.settings)),
          const SizedBox(
            width: appPadding,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color:white),
        child: TabBarWidget(
          tabs: const [
            Tab(
              icon: Icon(Icons.notifications_active),
              text: 'En cours',
            ),
            Tab(
              icon: Icon(Icons.content_paste_outlined),
              text: 'Terminé',
            ),
          ],
          children: [ActiveContent(), CompleteContent()],
        ),
      ),
    );
  }
}
