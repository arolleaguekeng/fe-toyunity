import 'package:toyunity/screens/orders/order_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/active_model.dart';
import 'active_item_card.dart';

class ActiveContent extends StatefulWidget {
  const ActiveContent({Key? key}) : super(key: key);

  @override
  State<ActiveContent> createState() => _ActiveContent();
}

class _ActiveContent extends State<ActiveContent> {
  bool isLoading = true;
  List<ActiveItemCard> ActiveList = [
    ActiveItemCard(
      ActiveItem: ActiveModel(
          name: "Poupé",
          quantity: '1',
          status: "",
          price: "30000",
          image: "assets/images/png/toy1.jpg"),
    ),
    ActiveItemCard(
      ActiveItem: ActiveModel(
          name: "voiture mi",
          quantity: '3',
          status: "",
          price: "5000",
          image: "assets/images/png/toy2.jpg"),
    ),
    ActiveItemCard(
      ActiveItem: ActiveModel(
          name: "Poivron",
          quantity: '1sac',
          status: "",
          price: "1200",
          image: "assets/images/png/toy3.jpg"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: ActiveList.length,
        itemBuilder: (context, index) => ActiveList[index],
      ),
    );
  }
}
