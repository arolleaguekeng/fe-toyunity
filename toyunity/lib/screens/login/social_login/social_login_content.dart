import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';
import '../../../constants/responsive.dart';
import '../../../main.dart';
import '../../../services/auth_services.dart';
import '../../components/forms/custom_button.dart';
import '../../components/forms/custom_text.dart';
import '../../home/home_screen.dart';
import '../../navigations/navigation_screen.dart';
import '../../shared_ui/showSnackBar.dart';
import '../../web_design/home/home_screen.dart';
import '../phone_number_login/phone_login_screen.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContent();
}

class _LoginContent extends State<LoginContent> {
  bool isLoading = false;
  bool inLoginProcess = false;
  void initState() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          margin: Responsive.isDesktop(context)
              ? EdgeInsets.only(top: size.height / 4)
              : EdgeInsets.all(appPadding),
          width: size.width,
          height: size.height,
          child: Responsive.isMobile(context)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: loginContent(size, context),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: loginContent(size, context),
                ),
        ),
      ),
    );
  }

  List<Widget> loginContent(Size size, BuildContext context) {
    var size = MediaQuery.of(context).size;
    return [
      if (Responsive.isMobile(context))
      Container(
        width: Responsive.isMobile(context) ? size.width : size.width / 3,
        child: svglogin(size, context),
      ),
      const SizedBox(
        height: appPadding,
      ),
      Container(
        width: Responsive.isMobile(context) ? size.width : size.width / 2,
        child: Column(
          children: [
            if (!Responsive.isMobile(context))
              const CustumText(
                text: "Rejoignez Nous !",
                size: 35,
                weight: FontWeight.bold,
                color: primaryColor,
              ),
            SizedBox(
              height: appPadding * 3,
            ),
            isLoading == false
                ? buildConatainerIcons(
                    iconUrl: "assets/icons/ic_google.png",
                    text: "Continuer avec Google",
                    ontap: () {
                      setState(() {
                        signIn(context);
                      });
                      print("Try to login with Google");
                      setState(() {
                        isLoading = true;
                      });
                    })
                : CircularProgressIndicator(),
            const SizedBox(
              height: appPadding,
            ),
            buildConatainerIcons(
                iconUrl: "assets/icons/ic_faceboock.png",
                text: "Continuer avec Faceboock",
                ontap: () {}),
            const SizedBox(
              height: appPadding,
            ),
            const SizedBox(
              height: appPadding,
            ),
            const CustumText(
              text: "OU",
              size: 16,
              color: lightTextColor,
            ),
            const SizedBox(
              height: appPadding * 2,
            ),
            Container(
              width: 400,
              child: CustomButton(
                  text: "Continuer avec le Telephone",
                  width: size.width * 0.8,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PhoneLoginScreen()));
                  }),
            ),
          ],
        ),
      ),
      if (!Responsive.isMobile(context))
      Container(
        width: Responsive.isMobile(context) ? size.width : size.width / 3,
        child: svglogin(size, context),
      ),
    ];
  }

  Column svglogin(Size size, BuildContext context) {
    return Column(
        children: [
          SvgPicture.asset(
            "assets/images/svg/baby.svg",
            width: size.width / 3,
          ),
          const SizedBox(
            height: appPadding,
          ),
          if (Responsive.isMobile(context))
            const CustumText(
              text: "Rejoignez Nous !",
              size: 35,
              weight: FontWeight.bold,
              color: primaryColor,
            ),
        ],
      );
  }

  GestureDetector buildConatainerIcons(
      {required String iconUrl,
      required String text,
      required Function() ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 400,
        padding: EdgeInsets.all(8),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
          BoxShadow(
            color: bgLightColor.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              child: Image.asset(iconUrl),
            ),
            const SizedBox(
              width: appPadding,
            ),
            CustumText(text: text, size: 16)
          ],
        ),
      ),
    );
  }

  void signIn(BuildContext context) async {
    if (kIsWeb) {
      setState(() {
        inLoginProcess = true;
        var state = AuthService.signInWithGoogle(
            context: context,
            widget: NavigationScreen(
              screen: HomeScreen(),
            ));
        if (MyApp.currentUser != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => HomeWebScreen()));
        }
      });
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() async {
            inLoginProcess = true;
            AuthService.signInWithGoogle(
                context: context,
                widget: NavigationScreen(
                  screen: HomeScreen(),
                ));
          });
        }
      } on SocketException catch (_) {
        showNotification(context, 'No Network Access...');
      }
    }
  }
}
