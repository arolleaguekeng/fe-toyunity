import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toyunity/routes/custum_routes.dart';
import 'package:toyunity/screens/welcome/welcom_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:toyunity/services/api/user_api.dart';

import 'constants/constants.dart';
import 'models/toy_model.dart';
import 'models/user_model.dart';
import 'screens/web_design/home/home_screen.dart';

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
  MyApp({super.key});
  static var auth = FirebaseAuth.instance;
  static UserModel? currentUser;
  static List<ToyModelCart> CARD = [];

  static Color appBarColor = primaryColor;
  // This widget is the root of your application  .
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Toyunity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Urbanist',
          primaryColor: Colors.white,
          secondaryHeaderColor: Colors.white,
          textTheme: const TextTheme(bodyText2: TextStyle(color: textColor)),
          backgroundColor: Colors.brown),
      home: kIsWeb ? HomeWebScreen() : WelcomeScreen(),
      color: secondaryColor,
      onGenerateRoute: CustomRoute.allRoutes,
    );
  }
}
