import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toyunity/screens/navigations/navigation_screen.dart';
import 'package:toyunity/screens/welcome/welcom_screen.dart';

import 'home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
              "https:assets3.lottiefiles.com/packages/lf20_AMBEWz.json",
              controller: _controller, onLoaded: (compos) {
            _controller
              ..duration = compos.duration
              ..forward().then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => NavigationScreen(
                            screen: HomeScreen(),
                          ))));
          }),
          Center(child: const Text("ToyUnity"))
        ],
      ),
    );
  }
}
