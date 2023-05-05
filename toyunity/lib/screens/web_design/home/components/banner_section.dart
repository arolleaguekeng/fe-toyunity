import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/screens/components/forms/costum_text_field.dart';
import 'package:toyunity/screens/components/forms/custom_button.dart';

import '../../../../constants/responsive.dart';

class BannerSection extends StatefulWidget {
  const BannerSection({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerSection> createState() => _BannerSectionState();
}

class _BannerSectionState extends State<BannerSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            child: Lottie.asset("assets/images/lotti/cat.json",
                controller: _animationController, onLoaded: (compos) {
              _animationController
                ..duration = compos.duration
                ..forward();
                _animationController.repeat();
            }),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        const Expanded(
          flex: 3,
          child: AboutSection(),
        ),
      ],
    );
  }
}

class MobBanner extends StatefulWidget {
  const MobBanner({Key? key}) : super(key: key);

  @override
  _MobBannerState createState() => _MobBannerState();
}

class _MobBannerState extends State<MobBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: Responsive.isMobile(context) ? 150 : 250,
              width:  Responsive.isMobile(context) ? 150 : 250,
              child: Lottie.asset("assets/images/lotti/cat.json",
                  controller: _animationController, onLoaded: (compos) {
                _animationController
                  ..duration = compos.duration
                  ..forward();
                  _animationController.repeat();
              }),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        const AboutSection(),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // ignore: prefer_const_constructors
        //it will adjust its size according to screeen
        const AutoSizeText(
          "Echange simple",
          maxLines: 1,
          style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const AutoSizeText(
          "Les jouets de vos rêve à porter de main",
          maxLines: 1,
          style: TextStyle(
            fontSize: 56,
            color: secondaryColor
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Echanger vos jouets gratuitement, rapidement et sans frais !",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 50,
            child: CustomTextField(
                icon: Icons.search_rounded,
                hintText: "Rechercher un jouet...",
                onChanged: (value) {},
                controller: TextEditingController())),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  width: 140,
                  child: CustomButton(
                    text: 'Voir le cathalogue',
                    onPressed: () {},
                  )),
            ),
            spacerWidth,
            Expanded(
              flex: 2,
              child: Container(
                  width: 140,
                  child: CustomButton(
                    text: 'Echanger un Jouet',
                    onPressed: () {},
                  )),
            ),
          ],
        )
      ],
    );
  }
}
