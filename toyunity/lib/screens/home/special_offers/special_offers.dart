import 'package:flutter/material.dart';
import 'package:toyunity/screens/home/special_offers/special_offer_product_item.dart';

import '../../../constants/constants.dart';
import '../../../models/categories.dart';
import '../../../models/toy_model.dart';
import '../../../routes/routes_name.dart';
import '../../../services/api/toy_api.dart';
import '../../components/forms/custom_text.dart';

class SpecialOfferCard extends StatefulWidget {
  const SpecialOfferCard({Key? key}) : super(key: key);

  @override
  State<SpecialOfferCard> createState() => _SpecialOfferCardState();
}

class _SpecialOfferCardState extends State<SpecialOfferCard> {
  bool isLoading = true;
  List<Categorie> selectedCategorie = [];
  List<ToyModel> toys = [];

  Future<void> getMupesSpecial() async {
    var liste = await ApiToy.getMostPopularToys();
    toys = <ToyModel>[];
    toys = liste;
    setState(() {
      isLoading = false;
    });
  }

  void initState() {
    getMupesSpecial();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustumText(
                text: 'Nouveautés :',
                size: 24,
                weight: FontWeight.bold,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, special_all);
                },
                child: CustumText(text: 'See all', size: 14, color: green),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 320,
          child: isLoading? Container(width: 50,height: 50,child: CircularProgressIndicator(color: secondaryColor,)) : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SoToyCard(
                toy: toys[index],
                likebtn: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star,
                    color: green,
                    size: 30,
                  ),
                ),
              );
            },
            itemCount: toys.length,
          ),
        ),
      ],
    );
  }
}
