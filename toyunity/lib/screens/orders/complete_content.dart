import 'package:toyunity/screens/orders/order_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/active_model.dart';
import 'active_item_card.dart';
import 'complete_item_card.dart';

class CompleteContent extends StatefulWidget {
  const CompleteContent({Key? key}) : super(key: key);

  @override
  State<CompleteContent> createState() => _CompleteContent();
}

class _CompleteContent extends State<CompleteContent> {
  bool isLoading = true;
  List<CompleteItemCard> ActiveList = [
    CompleteItemCard(
      ActiveItem: ActiveModel(
          name: "Poupé",
          quantity: '1',
          status: "",
          price: "30000",
          image: "assets/images/png/toy1.jpg"),
    ),
    CompleteItemCard(
      ActiveItem: ActiveModel(
          name: "voiture",
          quantity: '1',
          status: "",
          price: "30000",
          image: "assets/images/png/toy2.jpg"),
    ),
    CompleteItemCard(
      ActiveItem: ActiveModel(
          name: "Ballon",
          quantity: '1',
          status: "",
          price: "30000",
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
