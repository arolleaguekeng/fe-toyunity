import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/responsive.dart';
import '../../../models/categories.dart';
import '../../../models/toy_model.dart';
import '../../../routes/routes_name.dart';
import '../../../services/api/toy_api.dart';
import '../../components/forms/custom_text.dart';
import 'most_popular_product_card.dart';

class MostPopularCard extends StatefulWidget {
  const MostPopularCard({Key? key}) : super(key: key);

  @override
  State<MostPopularCard> createState() => _MostPopularCardState();
}

class _MostPopularCardState extends State<MostPopularCard> {
  bool isLoading = true;
  
  List<Categorie> selectedCategorie = [];
  List<ToyModel> toys = [];

  Future<void> getMostPopular() async {
    var liste = await ApiToy.getMostPopularToys();
    toys = liste;
    setState(() {
      isLoading = false;
    });
  }

  void initState() {
    getMostPopular();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustumText(text: 'Most Popular', size: 14),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, popular_all);
                },
                child: CustumText(text: ' See All', size: 14, color: green),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          height: 30,
          child: isLoading? CircularProgressIndicator(color: secondaryColor,) : ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildCard(
                cplant: categories[index],
                isSelected: categories[index].isSelected,
                index: index,
              );
            },
            separatorBuilder: (_, __) {
              return const Divider();
            },
            itemCount: categories.length,
          ),
        ),
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
              return MpToyCard(
                toy: toys[index],
                btnicon: IconButton(
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
    );
  }

  Widget buildCard({
    required Categorie cplant,
    required bool isSelected,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          categories[index].isSelected = !categories[index].isSelected;
          if (categories[index].isSelected == true) {
            selectedCategorie.add(
              Categorie(
                name: categories[index].name,
                isSelected: true,
              ),
            );
          } else if (categories[index].isSelected == false) {
            selectedCategorie.removeWhere(
                (element) => element.name == categories[index].name);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: cplant.isSelected ? green : Colors.transparent,
          border: Border.all(width: 2, color: green),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5),
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            cplant.name,
            style: TextStyle(
              fontSize: 12,
              color: cplant.isSelected ? white : green,
            ),
          ),
        ),
      ),
    );
  }
}
