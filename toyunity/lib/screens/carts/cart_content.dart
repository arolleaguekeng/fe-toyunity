import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/main.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:toyunity/screens/components/forms/custom_button.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../paiement/paiement_screen.dart';
import '../product/product_details/product_details_screen.dart';
import 'cart_product_card.dart';

/// Display cart Content page
class CartContent extends StatefulWidget {
  const CartContent({Key? key}) : super(key: key);
  static List<ToyModel> toyList = MyApp.CARD;
  @override
  State<CartContent> createState() => _CartContent();
}

class _CartContent extends State<CartContent> {
  bool isLoading = true;
  var toyList = [];
  double amound = 0;
  void initState() {
    toyList = CartContent.toyList;
    if (toyList.isNotEmpty) {
      isLoading = false;
      //toyList = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var prd in MyApp.CARD) {
      amound +=  prd.price * prd.quantity;
    }
    var size = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          title: const CustumText(
            text: "My Cart",
            size: 20,
            weight: FontWeight.bold,
          ),
          leading: Row(
            children: [
              SizedBox(
                width: appPadding,
              ),
              Container(
                width: 30,
                height: 30,
                child: Image.asset("assets/images/png/logo.png"),
              ),
            ],
          ),
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  //your code
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                )),

            //Add more icon here
          ],
        ),
        body: toyList.isNotEmpty
            ? Container(
                decoration: const BoxDecoration(color: white),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(color: bgLightColor),
                        padding: EdgeInsets.all(appPadding),
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: toyList.length,
                                itemBuilder: (context, index) => ToyCard(
                                  toyModel: toyList[index],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return ToyDetailsScreen(
                                              toy: toyList[index]);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                      SizedBox(
                        height: size.height * 0.10,
                      ),
                    ],
                  ),
                ))
            : Container(
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/svg/emptylist.svg"),
                      const SizedBox(
                        height: appPadding,
                      ),
                      const CustumText(
                        text: "Your cart is Empty",
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                      const CustumText(
                        text: "You don't have any items added",
                        size: 14,
                      ),
                    ],
                  )
                ],
              )),
        bottomNavigationBar: toyList.isNotEmpty
            ? BottomAppBar(
                color: white,
                elevation: 10,
                shape: AutomaticNotchedShape(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Container(
                    padding: const EdgeInsets.all(appPadding),
                    height: 120,
                    width: double.maxFinite,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [
                        CustumText(
                          text: "${amound} XAF",
                          size: 20,
                          color: textColor,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: appPadding,
                        ),
                        CustomButton(
                            text: "Chechkout",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => PaiementScreen()));
                            })
                      ],
                    )),
              )
            : const Text(""),
      ),
    );
  }
}
