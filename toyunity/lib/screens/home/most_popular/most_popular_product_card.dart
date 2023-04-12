import 'package:toyunity/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../../constants/responsive.dart';
import '../../../models/toy_model.dart';
import '../../components/forms/custom_text.dart';
import '../../product/product_details/product_details_screen.dart';

class MpToyCard extends StatelessWidget {
  final ToyModel toy;
  final IconButton btnicon;
  const MpToyCard({super.key, required this.toy, required this.btnicon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return ToyDetailsScreen(toy: toy);
            },
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                height: 205,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          toy.images[0],
                          height: Responsive.isMobile(context) ? 190 : 200,
                          width: 260,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20.0,
                      left: 100.0,
                      child: btnicon,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustumText(
                        text: toy.name,
                        size: 14,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: green,
                        size: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: CustumText(
                          text: '4.8',
                          size: 12,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 10,
                        width: 2,
                        color: Colors.black,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                        ),
                        child: CustumText(
                          text: '3405 Sold',
                          size: 12,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  CustumText(
                    text: toy.price,
                    size: 13,
                    color: primaryColor,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
