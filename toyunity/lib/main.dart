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
import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCThibdQlziIE70rTXU8BhveRAHQWJeq_g",
          authDomain: "toyunity.firebaseapp.com",
          projectId: "toyunity",
          storageBucket: "toyunity",
          messagingSenderId: "856757854744",
          appId: "1:856757854744:web:56dc778d210b57a5f0596d"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static var auth = FirebaseAuth.instance;
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
          primarySwatch: Colors.green,
          secondaryHeaderColor: Colors.white,
          textTheme: const TextTheme(bodyText2: TextStyle(color: textColor)),
          backgroundColor: Colors.brown),
      home: kIsWeb ? HomeWebScreen() : HomeWebScreen(),
      color: secondaryColor,
      onGenerateRoute: CustomRoute.allRoutes,
    );
  }
}
