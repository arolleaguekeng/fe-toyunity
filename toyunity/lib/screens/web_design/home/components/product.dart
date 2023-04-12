import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/constants/responsive.dart';
import 'package:toyunity/models/toy_model.dart';

class Toys extends StatelessWidget {
  const Toys({
    Key? key,
    required this.toy,
    required this.press,
  }) : super(key: key);
  final ToyModel toy;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(appPadding / 2),
      child: InkWell(
          onTap: press,
          child: Container(
            height: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    toy.images[0],
                    height: Responsive.isMobile(context) ? 210 : 240,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                AutoSizeText(
                  toy.name,
                  maxLines: 2,
                  minFontSize: 14,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                AutoSizeText(
                  toy.name,
                  maxLines: 2,
                  minFontSize: 14,
                  style: const TextStyle(fontSize: 15, color: grey),
                ),
                Row(
                  children: [
                    AutoSizeText(
                      "${toy.price} XAF",
                      maxLines: 2,
                      minFontSize: 14,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const AutoSizeText(
                      "par nuit",
                      maxLines: 2,
                      minFontSize: 14,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
