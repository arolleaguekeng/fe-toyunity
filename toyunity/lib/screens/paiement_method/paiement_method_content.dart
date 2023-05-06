import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../constants/responsive.dart';
import '../components/forms/custom_text.dart';
import '../home/home_screen.dart';
import '../web_design/home/home_screen.dart';

class PaiementMethodContent extends StatefulWidget {
  const PaiementMethodContent({Key? key}) : super(key: key);

  @override
  State<PaiementMethodContent> createState() => _PaiementMethodContent();
}

class _PaiementMethodContent extends State<PaiementMethodContent> {
  bool isLoading = true;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: size.height / 10),
            child: Container(
              width: size.width,
              child: Responsive.isMobile(context)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: loginContent(size, context),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: loginContent(size, context),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> loginContent(Size size, BuildContext context) {
    var size = MediaQuery.of(context).size;
    var paiements = [
      buildConatainerIcons("assets/images/png/orange.png", "Orange Money"),
      buildConatainerIcons("assets/images/png/mtn.png", "Mobile Money"),
      buildConatainerIcons("assets/images/png/paypal.png", "Paypal"),
      buildConatainerIcons("assets/images/png/master.png", "Master Card"),
    ];
    return [
      Container(
        width: Responsive.isMobile(context) ? size.width : size.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!Responsive.isMobile(context))
              Image.asset(
                "assets/images/png/pay.png",
                width: size.width / 3.2,
              ),
            const SizedBox(
              height: appPadding,
            ),
            if (Responsive.isMobile(context))
              const CustumText(
                text: "Choisir le mode de paiement",
                size: 35,
                weight: FontWeight.bold,
                color: primaryColor,
              ),
          ],
        ),
      ),
      const SizedBox(
        height: appPadding,
      ),
      Container(
        width: Responsive.isMobile(context) ? size.width : size.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!Responsive.isMobile(context))
              const CustumText(
                text: "Choisir le mode de paiement",
                size: 35,
                weight: FontWeight.bold,
                color: primaryColor,
              ),
            if (!Responsive.isMobile(context))
              const SizedBox(
                height: appPadding * 2,
              ),
            Container(
              margin:
                  EdgeInsets.only(left: size.width * 0.13, top: appPadding * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      paiements[0],
                      spacerWidth,
                      paiements[1],
                    ],
                  ),
                  spacerHeight,
                  Row(
                    children: [
                      paiements[2],
                      spacerWidth,
                      paiements[3],
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ];
  }

  GestureDetector buildConatainerIcons(String iconUrl, String text) {
    Future<void> _showSimpleDialog() async {
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              // <-- SEE HERE
              title: const CustumText(
                text: 'Voulez vous continuer ?',
                size: 30,
                color: primaryColor,
              ),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                kIsWeb ? HomeWebScreen() : HomeScreen()));
                  },
                  child: const CustumText(
                      text: "oui j'ai fais mon choix", size: 20),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const CustumText(
                      text: "Non J'ai changé d'avis", size: 20),
                ),
              ],
            );
          });
    }

    return GestureDetector(
        onTap: _showSimpleDialog,
        child: Material(
            borderRadius: BorderRadius.circular(15),
            elevation: 3,
            child: Container(
              height: 120,
              width: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    iconUrl,
                    width: 100,
                  ),
                ],
              ),
            )));
  }
}
