import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toyunity/constants/constants.dart';

class ServicesCard extends StatelessWidget {
  const ServicesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Services(
          image: 'assets/images/lotti/duck.json',
          title: "B to B marquet",
        ),
        const Services(
          image: 'assets/images/lotti/buy.json',
          title: "Toys delivery",
        ),
        const Services(
          image: 'assets/images/lotti/train.json',
          title: "Chat directly with the producer",
        ),
      ],
    );
  }
}

class Services extends StatefulWidget {
  const Services({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);
  final String image, title;

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(appPadding),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: EdgeInsets.all(appPadding / 2),
          width: 300,
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: 80,
                      height: 80,
                      child: Lottie.asset(widget.image,
                          controller: _animationController, onLoaded: (compos) {
                        _animationController
                          ..duration = compos.duration
                          ..forward();
                        _animationController.repeat();
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                "We offer services such as :",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
