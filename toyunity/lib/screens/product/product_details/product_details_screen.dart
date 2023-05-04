import 'package:flutter/foundation.dart';
import 'package:toyunity/main.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/screens/product/product_details/product_details_web.dart';

import '../../../constants/constants.dart';
import '../../../constants/responsive.dart';
import '../../components/forms/custom_button.dart';
import '../../components/forms/custom_text.dart';
import 'product_details_content.dart';

class ToyDetailsScreen extends StatelessWidget {
  final ToyModel toy;
  ToyDetailsScreen({Key? key, required this.toy});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: kIsWeb && !Responsive.isMobile(context)
          ? null
          : AppBar(
              backgroundColor: white,
              elevation: 0,
              title: const CustumText(
                text: "Details du produit",
                size: 20,
                weight: FontWeight.bold,
              ),
              centerTitle: true,
              actions: [
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.notifications,
                        color: Colors.black,
                        size: 30,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondaryColor,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Center(
                              child: Text(
                                MyApp.CARD.length.toString(),
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                spacerWidth,
                spacerWidth
              ],
            ),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: kIsWeb && !Responsive.isMobile(context)
                  ? WebProductDetails(
                      toy: toy,
                    )
                  : DetailsCard(
                      toy: toy,
                    ),
            )
          ],
        ),
      ),
      bottomNavigationBar:kIsWeb && !Responsive.isMobile(context)
          ? null
          : BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: size.width * 0.4,
                child: IconButton(
                  onPressed: () {
                    MyApp.CARD.add(ToyModelCart(
                        id: toy.id,
                        uid: toy.uid,
                        name: toy.name,
                        description: toy.description,
                        price: toy.price,
                        images: toy.images,
                        createdAt: toy.createdAt,
                        color: toy.color,
                        status: toy.status,
                        updatedAt: toy.updatedAt,
                        coordinates: toy.coordinates));
                  },
                  icon: Icon(Icons.add),
                )),
            Container(
                width: size.width * 0.4,
                child: CustomButton(
                  text: "Echanger",
                  onPressed: () {},
                  bgcolor: secondaryColor,
                )),
            spacerWidth,
            Container(
                width: size.width * 0.4,
                child: CustomButton(
                  text: "discuter",
                  onPressed: () {},
                  bgcolor: primaryColor,
                )),
          ],
        ),
      ),
    );
  }
}
