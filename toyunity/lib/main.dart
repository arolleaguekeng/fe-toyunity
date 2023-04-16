import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toyunity/routes/custum_routes.dart';
import 'package:toyunity/screens/navigations/navigation_screen.dart';
import 'package:toyunity/screens/web_design/home/home_screen.dart';
import 'package:toyunity/screens/welcome/welcom_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'constants/constants.dart';
import 'models/toy_model.dart';
import 'models/user_model.dart';
import 'screens/chat/chat_screen/chat_home.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/social_login/social_login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBw6-KMcK1N936hqJhDg9fk72vyRBOCeUU",
          authDomain: "toy-unity.firebaseapp.com",
          projectId: "toy-unity",
          storageBucket: "toy-unity.appspot.com",
          messagingSenderId: "959851867881",
          appId: "1:959851867881:web:f870808c8171da6f794a78",
          measurementId: "G-MMETQW7FQ7"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Future<UserModel?> userSignedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      UserModel userModel = UserModel.fromJson(userData);
      return userModel;
    } else {
      return null;
    }
  }

  MyApp({super.key});

  static var auth = FirebaseAuth.instance;
  static UserModel? currentUser;
  static List<ToyModelCart> CARD = [];

  static Color appBarColor = primaryColor;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'toyunity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Urbanist',
          primarySwatch: Colors.orange,
          secondaryHeaderColor: Colors.white,
          textTheme: const TextTheme(bodyText2: TextStyle(color: textColor)),
          backgroundColor: Colors.brown),
      home: kIsWeb ? WelcomeScreen() : WelcomeScreen(),
      color: secondaryColor,
      onGenerateRoute: CustomRoute.allRoutes,
    );
  }
}
