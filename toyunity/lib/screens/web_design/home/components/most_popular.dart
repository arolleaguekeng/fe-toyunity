import 'package:toyunity/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/screens/carts/cart_product_card.dart';
import '../../../../services/api/toy_api.dart';
import 'toy.dart';

import '../../../../constants/responsive.dart';
import '../../../../models/categories.dart';
import '../../../../models/toy_model.dart';
import '../../../../services/db_services.dart';
import '../../../components/forms/custom_text.dart';
import '../../../home/most_popular/most_popular_screen.dart';
import '../../../product/product_details/product_details_screen.dart';

class MostPopular extends StatefulWidget {
  const MostPopular(
      {Key? key, required this.crossAxiscount, required this.aspectRatio})
      : super(key: key);
  final int crossAxiscount;
  final double aspectRatio;

  @override
  State<MostPopular> createState() => _MostPopular();
}

class _MostPopular extends State<MostPopular> {
  DataBaseService db = DataBaseService();
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

  _MostPopular({
    Key? key,
    this.crossAxiscount = 3,
    this.aspectRatio = 1.1,
  });
  final int crossAxiscount;
  final double aspectRatio;
  @override
  Widget build(BuildContext context) {
    return isLoading? CircularProgressIndicator(color: secondaryColor,) : Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustumText(
                text: 'Most Popular',
                size: 24,
                weight: FontWeight.bold,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PopularAllPage()));
                },
                child:
                    CustumText(text: 'See all', size: 14, color: primaryColor),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isMobile(context) ? 1 : 3,
              childAspectRatio: aspectRatio,
              mainAxisSpacing: 1),
          itemBuilder: (context, index) => Toys(
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ToyDetailsScreen(toy: toys[index])));
            },
            toy: toys[index],
          ),
          itemCount: toys.length,
        ),
      ],
    );
  }
}
