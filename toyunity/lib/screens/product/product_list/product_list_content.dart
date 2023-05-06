import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/main.dart';

import '../../../constants/constants.dart';
import '../../../models/toy_model.dart';
import '../../../services/api/toy_api.dart';
import '../../home/most_popular/most_popular_product_card.dart';

class UserToylistScreen extends StatefulWidget {
  const UserToylistScreen({Key? key}) : super(key: key);

  @override
  State<UserToylistScreen> createState() => _UserToylistScreen();
}

class _UserToylistScreen extends State<UserToylistScreen> {
  bool isLoading = true;
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
    for (var toy in toys) {
      if (toy.uid != MyApp.currentUser!.uid) {
        toys.remove(toy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? CircularProgressIndicator(
              color: secondaryColor,
            )
          : Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: toys.length == 0
                  ? Text("Vous n'avez pas de jouet")
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 300),
                              itemBuilder: (_, index) {
                                return MpToyCard(
                                  toy: toys[index],
                                  btnicon: IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: red,
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
