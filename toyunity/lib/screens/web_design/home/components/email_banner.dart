import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/constants/constants.dart';

class EmailBanner extends StatelessWidget {
  const EmailBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "assets/images/png/subscribe_banner.jpg",
              height: 200,
              width: 1230,
              fit: BoxFit.cover,
            )),
        Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const AutoSizeText(
                  "",
                  maxLines: 2,
                  minFontSize: 14,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 50,
                        width: 1230,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                bottomLeft: Radius.circular(15.0))),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Entrer votre Email ici",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none)),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0))),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
