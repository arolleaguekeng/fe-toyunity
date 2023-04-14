import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/screens/components/forms/custom_button.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:toyunity/screens/login/social_login/social_login_screen.dart';
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
    return Scaffold(
      // [PageView.builder] is use to manage Pagination page
      body: PageView.builder(
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
                    height: 135,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        boxShadow: [BoxShadow(color: Colors.black12)],
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(children: [
                      Lottie.network(
                          "https:assets3.lottiefiles.com/packages/lf20_AMBEWz.json",
                          controller: _animationController, onLoaded: (compos) {
                        _animationController
                          ..duration = compos.duration
                          ..forward().then((value) => print('hello'));
                      }),
                      Text(data[i].title),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: appPadding,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => buildDot(index)),
                  ),
                ),
              ],
            );
          }),
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
