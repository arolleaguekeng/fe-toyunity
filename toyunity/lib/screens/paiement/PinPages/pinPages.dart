import 'package:toyunity/constants/constants.dart';
import 'package:toyunity/screens/components/forms/custom_text.dart';
import 'package:toyunity/screens/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../navigations/navigation_screen.dart';

class PinPages extends StatefulWidget {
  const PinPages({super.key});

  @override
  State<PinPages> createState() => _PinPagesState();
}

class _PinPagesState extends State<PinPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: CustumText(
          text: "Enter your Pin",
          size: 18,
          weight: FontWeight.bold,
        ),
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.all(appPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustumText(
                  text: "Enter your Pin to Confirm payment",
                  size: 18,
                ),
                const SizedBox(
                  height: 15,
                ),
                Pinput(
                  length: 4,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                MaterialButton(
                  height: 50,
                  elevation: 0,
                  splashColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: primaryColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  child: Center(
                    child: CustumText(
                      text: "Continue",
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.0,
          ),
        ),
      ),
      scrollable: true,
      title: Icon(
        Icons.check,
        size: 50,
        color: primaryColor,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: CustumText(
                text: "Order Sucessfully",
                size: 20,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Expanded(
              child: CustumText(
                text: "You have successfully made order",
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (__) {
                      return NavigationScreen(
                        screen: OrderScreen(),
                      );
                    },
                  ),
                );
              },
              height: 50,
              elevation: 0,
              splashColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: primaryColor,
              child: Center(
                child: CustumText(
                  text: "View Order",
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          MaterialButton(
            onPressed: () {},
            height: 50,
            elevation: 0,
            splashColor: Colors.green.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.green.shade100,
            child: Center(
              child: CustumText(
                text: "E-receipt",
                size: 18,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[],
    );
  }
}
