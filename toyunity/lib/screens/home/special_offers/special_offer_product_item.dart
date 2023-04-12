import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/responsive.dart';
import '../../components/forms/custom_text.dart';
import '../../product/product_details/product_details_screen.dart';
class SoToyCard extends StatefulWidget {
  const SoToyCard({Key? key, required this.toy, required this.likebtn})
      : super(key: key);

  final ToyModel toy;
  final IconButton likebtn;

  @override
  State<SoToyCard> createState() => _SoToyCardState(toy, likebtn);
}

class _SoToyCardState extends State<SoToyCard> {
  final ToyModel toy;
  final IconButton likebtn;

  _SoToyCardState(this.toy, this.likebtn);
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
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
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                color: primaryColor,
                                size: 12,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: CustumText(
                                  text: '4.8',
                                  size: 12,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                height: 10,
                                width: 2,
                                color: Colors.black,
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: green),
                                ),
                                child: CustumText(
                                  text: '3405 Sold',
                                  size: 12,
                                  color: green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustumText(
                            text: toy.price,
                            size: 13,
                            color: green,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
