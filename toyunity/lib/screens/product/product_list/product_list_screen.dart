import 'package:toyunity/screens/toy/toy_list/toy_list_content.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ToyListScreen extends StatelessWidget {
  const ToyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              flex: 5,
              child: ToyListContent(),
            )
          ],
        ),
      ),
    );
  }
}
