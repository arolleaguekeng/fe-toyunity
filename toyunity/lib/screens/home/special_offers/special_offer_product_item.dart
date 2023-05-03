import 'package:cached_network_image/cached_network_image.dart';
import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:flutter/material.dart';

import '../../../constants/responsive.dart';
import '../../components/forms/custom_text.dart';
import '../../product/product_details/product_details_screen.dart';

class SoToyCard extends StatefulWidget {
  const SoToyCard({Key? key, required this.toy, required this.likebtn})
      : super(key: key);

  final ToyModel toy;
  final IconButton likebtn;

  @override
  State<SoToyCard> createState() => _SoToyCardState(toy, likebtn);
}

class _SoToyCardState extends State<SoToyCard> {
  final ToyModel toy;
  final IconButton likebtn;

  _SoToyCardState(this.toy, this.likebtn);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return ToyDetailsScreen(toy: toy);
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    child: CachedNetworkImage(
                      imageUrl: toy.images[0],
                      placeholder: (conteext, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      child: Container(
                        width: 30,
                        height: 30,
                        child: const Icon(Icons.star_border_rounded,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              CustumText(
                text: toy.price.toString(),
                size: 13,
                color: green,
                weight: FontWeight.bold,
              ),
              CustumText(
                text: toy.price.toString(),
                size: 13,
                color: green,
                weight: FontWeight.bold,
              ),
            ],
          ),
        ));
  }
}
