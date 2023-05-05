import 'package:flutter_svg/svg.dart';
import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'services_data.dart';

/// Display cart Page full screen
/// You can display it into one container
class ServivesContent extends StatefulWidget {
  const ServivesContent({Key? key}) : super(key: key);

  @override
  State<ServivesContent> createState() => _ServivesContent();
}

class _ServivesContent extends State<ServivesContent>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  int currentIndex = 0;
  late PageController _controller;
  late AnimationController _animationController;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var data = ServiceItemDatas;
    return Container(
        // [PageView.builder] is use to manage Pagination page
        child: Column(
      children: [
        Container(
          height: 155,
          child: PageView.builder(
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: ServiceItemDatas.length,
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    Material(
                      elevation: 6,
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            boxShadow: [BoxShadow(color: Colors.black12)],
                            borderRadius: BorderRadius.circular(30)),
                        child: Row(children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: SvgPicture.asset(data[i].image,),
                          ),
                          SizedBox(width: appPadding,),
                          CustumText(
                            size: 18,
                            text: data[i].title,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: appPadding,
                    ),
                  ],
                );
              }),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => buildDot(index)),
          ),
        ),
      ],
    ));
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
