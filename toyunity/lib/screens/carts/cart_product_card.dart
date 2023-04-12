import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:toyunity/screens/carts/cart_content.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:flutter/material.dart';

/// Display toy card item
class ToyCard extends StatefulWidget {
  final GestureTapCallback? onTap;
  final ToyModelCart toyModel;
  const ToyCard({super.key, this.onTap, required this.toyModel});
  @override
  State<StatefulWidget> createState() => _ToyCard(onTap, toyModel);
}

class _ToyCard extends State<ToyCard> {
  final GestureTapCallback? onTap;
  final ToyModelCart toyModel;
  _ToyCard(this.onTap, this.toyModel);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
        onTap: onTap,
        child: Container(
            child: Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.only(top: appPadding),
          padding: const EdgeInsets.all(appPadding / 2),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image.asset(toyModel.images[0]),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: white,
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: appPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustumText(text: toyModel.name, size: 16),
                      const SizedBox(
                        height: appPadding,
                      ),
                      CustumText(
                        text: "${toyModel.price} XAF",
                        size: 14,
                        weight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        height: appPadding,
                      ),
                      Container(
                        width: size.width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: bgLightColor,
                                  borderRadius: BorderRadius.circular(40)),
                              width: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (toyModel.quantity > 1) {
                                            var qty =
                                                toyModel.getquantity() - 1;
                                            toyModel.setquantity(qty);
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.remove_rounded,
                                          color: primaryColor, size: 15)),
                                  Text(
                                    toyModel.getquantity().toString(),
                                    style: const TextStyle(color: primaryColor),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (toyModel.quantity > 0) {
                                            var qty =
                                                toyModel.getquantity() + 1;
                                            toyModel.setquantity(qty);
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.add_rounded,
                                          color: primaryColor, size: 15)),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      CartContent.toyList.removeAt(CartContent
                                          .toyList
                                          .indexOf(toyModel));
                                      print(CartContent.toyList.length);
                                    });
                                  },
                                  icon:
                                      const Icon(Icons.delete_outline_rounded)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
