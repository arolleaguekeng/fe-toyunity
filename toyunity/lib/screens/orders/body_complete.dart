import 'package:toyunity/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../models/active_model.dart';
import 'active_item_card.dart';
import 'complete_item_card.dart';

class BodyCompleteCard extends StatelessWidget {
  const BodyCompleteCard({
    Key? key,
    required this.chatList,
  }) : super(key: key);

  final List<ActiveModel> chatList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
            left: appPadding * 0.5, right: appPadding * 0.3, top: 25),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: bgLightColor,
        ),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(appPadding),
          shrinkWrap: true,
          itemCount: chatList.length,
          itemBuilder: (context, index) => CompleteItemCard(
            ActiveItem: chatList[index],
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
