import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/models/toy_model.dart';
import 'package:toyunity/screens/components/forms/custom_button.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:flutter/material.dart';
import '../../../constants/responsive.dart';
import 'package:lottie/lottie.dart';

class DetailsCard extends StatefulWidget {
  final ToyModel toy;
  const DetailsCard({super.key, required this.toy});

  @override
  State<DetailsCard> createState() => _DetailsCardState(toy);
}

class _DetailsCardState extends State<DetailsCard>
    with SingleTickerProviderStateMixin {
  final ToyModel toy;
  bool isOpenened = false;
  late AnimationController _animationController;
  late PageController _controller;
  bool isLoading = true;
  int currentIndex = 0;
  _DetailsCardState(this.toy);
  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String imagePicture = widget.toy.images[0];
    return Scaffold(
      appBar: AppBar(
        title: const CustumText(
          text: "Details du produit",
          size: 20,
          weight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageView.builder(
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
                                    toy.images[i],
                                    height: Responsive.isMobile(context)
                                        ? 190
                                        : 200,
                                    width: 260,
                                    fit: BoxFit.cover,
                                  ),
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
                              text: toy.price,
                              size: 13,
                              color: green,
                              weight: FontWeight.bold,
                            ),
                            CustumText(
                              text: toy.price,
                              size: 13,
                              color: green,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ));
                }),
            spacerHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                  ],
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: size.width * 0.4,
                height: size.height * 0.4,
                child: CustomButton(
                  text: "Acheter",
                  onPressed: () {},
                  bgcolor: secondaryColor,
                )),
            Container(
                child: CustomButton(
              text: "Echanger",
              onPressed: () {},
              bgcolor: primaryColor,
            )),
          ],
        ),
      ),
    );
  }
}
