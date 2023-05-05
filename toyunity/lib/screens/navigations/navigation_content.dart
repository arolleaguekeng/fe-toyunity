import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toyunity/main.dart';
import 'package:toyunity/screens/carts/cart_screen.dart';
import 'package:toyunity/screens/home/home_content.dart';
import 'package:toyunity/screens/home/home_screen.dart';
import 'package:toyunity/screens/orders/orders_screen.dart';
import 'package:toyunity/screens/producer/pcer_poducts_list_screen.dart';
import 'package:toyunity/screens/profiles/profiles_screen.dart';
import 'package:toyunity/screens/wallets/wallets_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/user_model.dart';
import '../chat/chat_screen/chat_home.dart';
import '../login/social_login/social_login_screen.dart';

late TextEditingController myController;

class NavigationContent extends StatefulWidget {
  NavigationContent({Key? key, required this.currentPage}) : super(key: key);
  Widget currentPage = HomeScreen();

  @override
  State<NavigationContent> createState() => _NavigationContent(currentPage!);
}

class _NavigationContent extends State<NavigationContent> {
  Widget currentPage;
  int currentTab = 0;
  bool isProducer = false;
  final List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    OrderScreen(),
    WalletScreen(),
    ProfileScreen(),
    PcToyListScreen(),
  ];
  AppBar? appBar = null;

  final PageStorageBucket bucket = PageStorageBucket();

  _NavigationContent(this.currentPage);
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    if (currentPage == null) {
      currentPage = HomeScreen();
    }
    return Scaffold(
      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.symmetric(horizontal: appPadding),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              appBarIcon("Home", Icons.home_filled, 0, HomeScreen()),
              appBarIcon("Carte", Icons.shopping_bag_rounded, 1, CartScreen()),
              appBarIcon("Commandes", Icons.shopping_cart, 2, OrderScreen()),
              appBarIcon(
                  "Messages", Icons.message_outlined, 3, ChatHomeScreen()),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton appBarIcon(String text, icon, int tab, Widget screen) {
    return MaterialButton(
        minWidth: 60,
        onPressed: () {
          setState(
            () {
              if (currentPage != const HomeScreen() && MyApp.auth.currentUser == null) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              } else {
                currentPage = screen;
                currentTab = tab;
              }
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   text,
            //   style: TextStyle(color: currentTab == tab ? primaryColor : white),
            // )
            CircleAvatar(
              backgroundColor: currentTab == tab ? secondaryColor : transparent,
              child: SizedBox(
                height: 36,
                width: 36,
                child:
                    Icon(icon, color: currentTab == tab ? white : Colors.grey),
              ),
            ),
            if (currentTab == tab)
              Text(
                text,
                style:
                    TextStyle(color: currentTab == tab ? white : Colors.grey),
              )
          ],
        ));
  }

  Future<Widget> userSignedIn() async {
    User? user = MyApp.auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      UserModel userModel = UserModel.fromJson(userData);
      return ChatHomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
