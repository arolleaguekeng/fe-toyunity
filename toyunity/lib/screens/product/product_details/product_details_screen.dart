import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:toyunity/main.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/screens/paiement_method/paiement_method_screen.dart';
import 'package:toyunity/screens/product/product_details/product_details_web.dart';

import '../../../constants/constants.dart';
import '../../../constants/responsive.dart';
import '../../chat/chat_screen/chat_screen.dart';
import '../../components/forms/custom_button.dart';
import '../../components/forms/custom_text.dart';
import '../../login/social_login/social_login_screen.dart';
import '../product_list/product_list_content.dart';
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
              backgroundColor: primaryColor,
              elevation: 0,
              title: const CustumText(
                text: "Details du produit",
                size: 20,
                color: white,
                weight: FontWeight.bold,
              ),
              centerTitle: true,
              actions: [
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_bag,
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
      bottomNavigationBar: kIsWeb && !Responsive.isMobile(context)
          ? null
          : BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 100,
                      child: CustomButton(
                        text: "Echanger",
                        onPressed: () {
                          showSimpleDialog(context);
                        },
                        bgcolor: secondaryColor,
                      )),
                  spacerWidth,
                  Container(
                      width: 100,
                      child: CustomButton(
                        text: "discuter",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      currentUser: MyApp.currentUser!,
                                      friendId: toy.uid,
                                      friendName: "Vendeur",
                                      friendImage: "")));
                        },
                        bgcolor: primaryColor,
                      )),
                ],
              ),
            ),
    );
  }

  static Future<void> showSimpleDialog(context) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            // <-- SEE HERE
            title: const CustumText(
              text: 'Avez vous un jouet à échanger ?',
              size: 18,
              color: primaryColor,
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StreamBuilder<User?>(
                                stream: MyApp.auth.authStateChanges(),
                                builder: (context, snapshot) {
                                  return snapshot.data == null
                                      ? const LoginScreen()
                                      : UserToylistScreen();
                                },
                              )));
                },
                child: const CustumText(text: "Oui", size: 20),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StreamBuilder<User?>(
                                stream: MyApp.auth.authStateChanges(),
                                builder: (context, snapshot) {
                                  return snapshot.data == null
                                      ? const LoginScreen()
                                      : PaiementMethodScreen();
                                },
                              )));
                },
                child: const CustumText(text: "Non", size: 20),
              ),
            ],
          );
        });
  }
}
