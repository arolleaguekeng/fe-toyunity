import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/constants/responsive.dart';
import 'menu.dart';

class Footer extends StatelessWidget {
  var kSecondaryColor;

  Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: bgLightColor,
      child: Container(
        width: kMaxWidth,
        padding: EdgeInsets.all(webPadding),
        constraints: BoxConstraints(maxWidth: kMaxWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Image.asset("assets/images/png/logo.png"),
                          ),
                          const SizedBox(
                            width: appPadding,
                          ),
                          Text(
                            "toyunity",
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w900,
                                color: kSecondaryColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SocialIcon(
                            icon: "icons/google-icon.svg",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SocialIcon(
                            icon: "icons/facebook-2.svg",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SocialIcon(
                            icon: "icons/twitter.svg",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (Responsive.isDesktop(context))
                  Expanded(flex: 3, child: HeaderWebMenu()),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            if (!Responsive.isDesktop(context)) MobFooterMenu(),
          ],
        ),
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
          )),
      child: SvgPicture.asset(icon),
    );
  }
}
