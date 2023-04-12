import 'package:toyunity/screens/home/most_popular/most_popular_screen.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/screens/home/special_offers/special_offer_product_item.dart';

import '../../../constants/constants.dart';
import '../../../models/categories.dart';
import '../../../models/toy_model.dart';

class SpecialApp extends StatefulWidget {
  const SpecialApp({super.key});

  @override
  State<SpecialApp> createState() => _SpecialAppState();
}

class _SpecialAppState extends State<SpecialApp> {
  bool isLoading = true;
  List<Categorie> selectedCategorie = [];
  List<ToyModel> toys = [];

  Future<void> getMupesInsurees() async {
    // var liste = await db.getAllToys();
    toys = <ToyModel>[];
    // toys = liste;
    setState(() {
      isLoading = false;
    });
  }

  void initState() {
    getMupesInsurees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custumAppBar(
        title: 'Special Popular',
        action: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 300),
                  itemBuilder: (_, index) {
                    return SoToyCard(
                      toy: toys[index],
                      likebtn: IconButton(
                        icon: Icon(
                          Icons.heart_broken,
                          color: green,
                        ),
                        onPressed: () {},
                      ),
                    );
                  },
                  itemCount: toys.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
