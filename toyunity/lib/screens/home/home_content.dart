import 'package:toyunity/models/categories.dart';
import 'package:toyunity/screens/components/forms/costum_text_field.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/screens/profiles/profiles_screen.dart';

import '../../constants/constants.dart';

import '../../models/toy_model.dart';
import '../../services/auth_services.dart';
import '../components/forms/custom_text.dart';
import 'most_popular/most_popular.dart';
import 'services/services_card.dart';
import 'special_offers/special_offers.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContent();
}

class _HomeContent extends State<HomeContent> {
  bool isLoading = true;
  // List<Categorie> selectedCategorie = [];
  List<ToyModel> toys = [];

  Future<void> getMupesInsurees() async {
    await AuthService.disconnect();
    // toys =  <ToyModel>[];
    // toys = liste;
    setState(() {
      isLoading = false;
    });
  }

  void initState()  {
    getMupesInsurees();
      
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    var size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(appPadding * 0.5),
      width: size.width * 0.9,
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: appPadding,
                    ),
                    Column(
                      children: const [
                        CustumText(
                          text: "Toy unity",
                          size: 16,
                          color: primaryColor,
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_rounded)),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
                      },
                      child: CircleAvatar(
                        backgroundImage:
                        AssetImage("assets/images/png/profile.png"),
                      ),
                    )

                  ],
                )
              ],
            ),
            const SizedBox(
              height: appPadding,
            ),
            // CustomTextField(
            //   hintText: "Search...",
            //   onChanged: (value) {},
            //   controller: searchController,
            //   icon: Icons.search_rounded,
            // ),
            Container(
              child: ServivesContent(),
            ),

            SpecialOfferCard(),
            MostPopularCard(),
          ],
        ),
      ),
    );
  }
}
