import 'package:cached_network_image/cached_network_image.dart';
import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../constants/responsive.dart';
import '../../../main.dart';

class DetailsCard extends StatefulWidget {
  final ToyModel toy;
  const DetailsCard({super.key, required this.toy});

  @override
  State<DetailsCard> createState() => _DetailsCardState(toy);
}

class _DetailsCardState extends State<DetailsCard> {
  final ToyModel toy;
  bool isOpenened = false;
  late PageController _controller;
  bool isLoading = true;
  int currentIndex = 0;
  _DetailsCardState(this.toy);
  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String imagePicture = widget.toy.images[0];
    return Container(
      height: size.height,
      decoration: BoxDecoration(color: white),
      child: Column(
        children: [
          Container(
            height: 300,
            child: PageView.builder(
                controller: _controller,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: toy.images.length,
                itemBuilder: (_, i) {
                  return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) {
                        //       return ToyDetailsScreen(toy: toy);
                        //     },
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                    radius: 100,
                                    child: Image.asset(
                                      toy.images[0],
                                      fit: BoxFit.cover,
                                      height: Responsive.isMobile(context)
                                          ? 190
                                          : 200,
                                      width: 260,
                                    )
                                    // CachedNetworkImage(
                                    //   imageUrl: toy.images[0],
                                    //   height: Responsive.isMobile(context)
                                    //       ? 190
                                    //       : 200,
                                    //   width: 260,
                                    //   placeholder: (conteext, url) =>
                                    //       const CircularProgressIndicator(),
                                    //   errorWidget: (context, url, error) =>
                                    //       Icon(
                                    //     Icons.error,
                                    //   ),
                                    // )
                                    ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: const Icon(
                                          Icons.star_border_rounded,
                                          size: 20,
                                          color: Colors.white),
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
                }),
          ),
          spacerHeight,
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(toy.images.length, (index) => buildDot(index)),
            ),
          ),
          spacerHeight,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustumText(
                    text: toy.name,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  CustumText(
                    text: toy.description,
                    size: 14,
                  ),
                ],
              ),
              Column(
                children: [
                  CustumText(
                    text: toy.name,
                    size: 14,
                  ),
                  CustumText(
                      text: "${toy.name} XAF",
                      size: 24,
                      weight: FontWeight.bold,
                      color: secondaryColor),
                      Center(
                        child: CircleAvatar(
                          child: Container(
                            color: primaryColor,
                          width: 60,
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
                            icon: Icon(Icons.shop),
                          )),
                        ),
                      ),
                ],
              )
            ],
          ),
          spacerHeight,
          CustumText(text: toy.description, size: 14)
        ],
      ),
    );
  }

  /// Create carousel Dot navigator
  Container buildDot(int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 20 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == index ? primaryColor : grey),
    );
  }
}
