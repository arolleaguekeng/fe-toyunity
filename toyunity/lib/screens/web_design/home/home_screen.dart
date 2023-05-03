// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toyunity/constants/constants.dart';
import '../../producer/add_products/add_product_screen.dart';
import 'components/body.dart';
import 'components/footer.dart';
import 'components/header_container.dart';
import 'components/menu.dart';

class HomeWebScreen extends StatefulWidget {
  const HomeWebScreen({Key? key}) : super(key: key);

  @override
  _HomeWebScreenState createState() => _HomeWebScreenState();
}

class _HomeWebScreenState extends State<HomeWebScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              DrawerHeader(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        child: Image.asset("assets/images/png/logo.png"),
                      ),
                      const SizedBox(
                        height: appPadding,
                      ),
                      Text(
                        "toyunity",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900,
                            color: primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              MobMenu()
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                //header
                HeaderContainer(),
                //body
                BodyContainer(),
                //footer
                SizedBox(
                  height: 30,
                ),
                Footer(),
                //now we make our website responsive
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add),backgroundColor: secondaryColor,onPressed: () {
        Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddToyScreen()));}));
  }
}
