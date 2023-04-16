import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toyunity/constants/constants.dart';

import '../../../../main.dart';
import '../../../../models/user_model.dart';
import '../../../../screens/home/home_screen.dart';
import '../../../carts/cart_screen.dart';
import '../../../chat/chat_screen/chat_home.dart';
import '../../../login/social_login/social_login_screen.dart';
import '../../../orders/orders_screen.dart';

class HeaderWebMenu extends StatelessWidget {
  const HeaderWebMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: menuItems(context),
    );
  }
}

class MobFooterMenu extends StatelessWidget {
  const MobFooterMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: menuItems(context),
    );
  }
}

class HeaderMenu extends StatelessWidget {
  const HeaderMenu({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);
  final String title;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class MobMenu extends StatefulWidget {
  const MobMenu({Key? key}) : super(key: key);

  @override
  _MobMenuState createState() => _MobMenuState();
}

class _MobMenuState extends State<MobMenu> {
  Future<Widget> userSignedIn() async {
    User? user = MyApp.auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      UserModel userModel = UserModel.fromJson(userData);
      return ChatHomeScreen(userModel);
    } else {
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: menuItems(context),
      ),
    );
  }
}

List<Widget> menuItems(BuildContext context) {
  return [
    HeaderMenu(
      press: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      },
      title: "Home",
    ),
    SizedBox(
      width: appPadding,
      height: appPadding,
    ),
    HeaderMenu(
      press: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => CartScreen()));
      },
      title: "Cart",
    ),
    SizedBox(
      width: appPadding,
      height: appPadding,
    ),
    HeaderMenu(
      press: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => OrderScreen()));
      },
      title: "Orders",
    ),
    SizedBox(
      width: appPadding,
      height: appPadding,
    ),
    HeaderMenu(
      press: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => MyApp.currentUser! == null
                    ? const LoginScreen()
                    : ChatHomeScreen(MyApp.currentUser!)));
      },
      title: "Chat",
    ),
  ];
}
