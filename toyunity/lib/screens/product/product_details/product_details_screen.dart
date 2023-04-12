import 'package:toyunity/models/toy_model.dart';
import 'package:toyunity/screens/toy/toy_details/toy_details_content.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ToyDetailsScreen extends StatelessWidget {
  final ToyModel toy;
  ToyDetailsScreen({Key? key, required this.toy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: DetailsCard(
                toy: toy,
              ),
            )
          ],
        ),
      ),
    );
  }
}
