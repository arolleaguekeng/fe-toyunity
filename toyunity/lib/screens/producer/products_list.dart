import 'package:toyunity/screens/home/home_content.dart';
import 'package:toyunity/screens/home/most_popular/most_popular_screen.dart';
import 'package:toyunity/services/api/toy_api.dart';
import 'package:toyunity/services/db_services.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../models/toy_model.dart';
import '../../models/categories.dart';
import '../home/special_offers/special_offer_product_item.dart';

class PcToyListContent extends StatefulWidget {
  const PcToyListContent({super.key});

  @override
  State<PcToyListContent> createState() => _PcToyListContent();
}

class _PcToyListContent extends State<PcToyListContent> {
  DataBaseService db = DataBaseService();
  bool isLoading = true;
  List<Categorie> selectedCategorie = [];
  List<ToyModel> toys = [];

  Future<void> getMupesInsurees() async {
    var liste = await ApiToy.getAllToys();
    toys = <ToyModel>[];
    toys = liste;
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
                      crossAxisCount: 1,
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
