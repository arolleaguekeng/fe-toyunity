import 'package:firebase_auth/firebase_auth.dart';
import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/main.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:toyunity/screens/components/forms/custom_button.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:flutter/material.dart';
import '../../login/social_login/social_login_screen.dart';
import '../../paiement_method/paiement_method_screen.dart';
import '../../web_design/home/components/header.dart';

class WebProductDetails extends StatefulWidget {
  final ToyModel toy;
  const WebProductDetails({super.key, required this.toy});

  @override
  State<WebProductDetails> createState() => _WebProductDetailsState(toy);
}

class _WebProductDetailsState extends State<WebProductDetails> {
  final ToyModel toy;

  _WebProductDetailsState(this.toy);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Header(),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.09,
                  right: size.width * 0.09,
                  top: appPadding * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  header(),
                  pictures(size),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustumText(
                            text: toy.description,
                            size: 25,
                            weight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              CustumText(
                                text: "2 ",
                                size: 16,
                              ),
                              CustumText(
                                text: "Jouets . ",
                                size: 16,
                              ),
                              CustumText(
                                text: "1 ",
                                size: 16,
                              ),
                              CustumText(
                                text: "Utilisateur . ",
                                size: 16,
                              ),
                              CustumText(
                                text: "1 ",
                                size: 16,
                              ),
                              CustumText(
                                text: "Quantité ",
                                size: 16,
                              ),
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
                            ],
                          ),
                          SizedBox(
                            height: appPadding,
                          ),
                          Divider(),
                          SizedBox(
                            height: appPadding,
                          ),
                          //options disponible
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              operationItem(
                                  title: 'publier à',
                                  description: 'Douala, Mars 2023',
                                  icon: Icons.shield_outlined),
                              const SizedBox(
                                height: appPadding,
                              ),
                              operationItem(
                                  title: 'lieux de retrai',
                                  description: "Bonamoussadi denver",
                                  icon: Icons.person),
                              const SizedBox(
                                height: appPadding,
                              ),
                              operationItem(
                                  title:
                                      'Annulation gratuite avant le 26 avril.',
                                  description: '',
                                  icon: Icons.calendar_month_rounded),
                              const SizedBox(
                                height: appPadding,
                              ),
                            ],
                          )
                        ],
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(appPadding),
                          child: Container(
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustumText(
                                  text: "${toy.price} XAF",
                                  size: 24,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: appPadding / 2,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star),
                                    CustumText(
                                      text: ("4,95 ."),
                                      size: 16,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: appPadding / 2,
                                ),
                                Row(
                                  children: [
                                    CustumText(
                                      text: "43",
                                      size: 20,
                                    ),
                                    CustumText(
                                      text: "Commentaires",
                                      size: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: appPadding / 2,
                                ),
                                CustomButton(
                                    text: "Echanger",
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  StreamBuilder<User?>(
                                                    stream: MyApp.auth
                                                        .authStateChanges(),
                                                    builder:
                                                        (context, snapshot) {
                                                      return snapshot.data ==
                                                              null
                                                          ? const PaiementMethodScreen()
                                                          : PaiementMethodScreen();
                                                    },
                                                  )));
                                    })
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row operationItem(
      {required String title,
      required String description,
      required IconData icon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustumText(
              text: title,
              size: 20,
              weight: FontWeight.w400,
            ),
            CustumText(
              text: description,
              size: 20,
              color: lightTextColor,
            ),
          ],
        )
      ],
    );
  }

  Row pictures(Size size) {
    double bigcardWidth = size.width * 0.39;
    double bigcardHeight = size.width * 0.3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            toy.images[0],
            height: bigcardHeight,
            width: bigcardWidth,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                smallPict(bigcardHeight, bigcardWidth, 1),
                smallPict(bigcardHeight, bigcardWidth, 2),
              ],
            ),
            Row(
              children: [
                smallPict(bigcardHeight, bigcardWidth, 3),
                smallPict(bigcardHeight, bigcardWidth, 4),
              ],
            ),
          ],
        )
      ],
    );
  }

  Padding smallPict(double bigcardHeight, double bigcardWidth, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset(
          toy.images[index],
          height: bigcardHeight / 2,
          width: bigcardWidth / 2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Column header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustumText(
          text: toy.name,
          size: 30,
          weight: FontWeight.bold,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.star),
                CustumText(
                  text: ("4,95 ."),
                  size: 16,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  width: appPadding,
                ),
                CustumText(
                  text: ("Superhôte ."),
                  size: 16,
                ),
                CustumText(
                  text: ("Aguekeng Arolle Dubois"),
                  size: 16,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            Row(
              children: const [
                Icon(Icons.share),
                CustumText(
                  text: ("Partager"),
                  size: 16,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  width: appPadding,
                ),
                Icon(Icons.heart_broken),
                CustumText(
                  text: ("Enregistrer"),
                  size: 16,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
