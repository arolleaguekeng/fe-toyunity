import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toyunity/screens/web_design/home/home_screen.dart';

import '../main.dart';
import '../models/user_model.dart';
import '../screens/navigations/navigation_screen.dart';
import '../screens/shared_ui/showSnackBar.dart';
import 'api/user_api.dart';
import 'package:flutter/material.dart';

/// Firebase user authentification manager
class AuthService {
  static final _auth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static GoogleAuthProvider googleProvider = GoogleAuthProvider();
  static UserModel? userData;

  //region Phone number and OTP Authentification
  /// Firebase authentification With Phone number
  static void authWithPhoneNumber(String phone,
      {required Function(String value, int? value1) onCodeSend,
      required Function(PhoneAuthCredential value) onAutoVerify,
      required Function(FirebaseAuthException value) onFailed,
      required Function(String value) autoRetrieval}) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 90),
      verificationCompleted: onAutoVerify,
      verificationFailed: onFailed,
      codeSent: onCodeSend,
      codeAutoRetrievalTimeout: autoRetrieval,
    );
  }

  /// Check OPT Code and SignIn
  static Future<void> validateOtp(String smsCode, String verificationId,
      BuildContext context, Widget widget) async {
    final _credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(_credential);
    var user = _auth.currentUser;
    var uid = user!.uid;
    DocumentSnapshot userExist =
        await firestore.collection('users').doc(uid).get();
    if (userExist.exists) {
      print("User Already Exists in Database");
      await addUserInFireBase(user);
      UserModel userData = await ApiUser.login(uid);
      print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
      MyApp.currentUser = userData;

      print(MyApp.currentUser);

      openHomePage(context, widget);
    } else {
      print(
          "///////////////////////////////////////////////////////////////////////////////");
      var userModel = UserModel(
          uid: uid,
          fullName: user.displayName,
          username: "invité",
          email: user.email,
          hasPassword: null,
          phone: user.phoneNumber,
          role: null,
          image: user.photoURL,
          city: null,
          state: null,
          country: null);
      try {
        await addUserInFireBase(user);
        ApiUser.signup(userModel);
        MyApp.currentUser = userModel;
        openHomePage(context, widget);
      } catch (_) {
        showNotification(context, 'No Network Access...');
      }
    }
    ApiUser.signup(UserModel(
        uid: user.uid,
        fullName: user.displayName,
        username: user.displayName!,
        email: user.email,
        hasPassword: null,
        phone: user.phoneNumber,
        role: 'user',
        image: user.photoURL,
        city: null,
        state: null,
        country: null));
    return;
  }
  // endregion

  static Future<void> addUserInFireBase(User currentUser) async {
    DocumentReference userRef =
        firestore.collection('users').doc(currentUser.uid);

    await userRef.set({
      'email': currentUser.email,
      'name': currentUser.displayName,
      'image': currentUser.photoURL,
      'uid': currentUser.uid,
      'date': DateTime.now(),
    });
  }

  // Connexion with google account
  static Future<UserCredential> signInWithGoogle(
      {required BuildContext context, required Widget widget}) async {
    if (kIsWeb) {
      var userCredential = await _auth.signInWithPopup(googleProvider);
      await loginUser(userCredential, context, widget);
      return userCredential;
    } else {
      // Create an instance of the firebase auth and google signin
      FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      //Triger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      //Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      //Create a new credentials
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      //Sign in the user with the credentials
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      print('loginnnnnn');
      await loginUser(userCredential, context, widget);
      return userCredential;
    }
  }

  static Future<void> loginUser(UserCredential userCredential,
      BuildContext context, Widget widget) async {
    var uid = userCredential.user!.uid;
    DocumentSnapshot userExist =
        await firestore.collection('users').doc(uid).get();
    if (userExist.exists) {
      print("User Already Exists in Database");
      await addUserInFireBase(userCredential.user!);
      UserModel userData = await ApiUser.login(uid);
      print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
      MyApp.currentUser = userData;

      print(MyApp.currentUser);

      openHomePage(context, widget);
    } else {
      var user = userCredential.user;
      print(
          "///////////////////////////////////////////////////////////////////////////////");
      var userModel = UserModel(
          uid: uid,
          fullName: user!.displayName,
          username: user.displayName!,
          email: user.email,
          hasPassword: null,
          phone: user.phoneNumber,
          role: null,
          image: user.photoURL,
          city: null,
          state: null,
          country: null);
      try {
        await addUserInFireBase(userCredential.user!);
        ApiUser.signup(userModel);
        MyApp.currentUser = userModel;
        openHomePage(context, widget);
      } catch (_) {
        showNotification(context, 'No Network Access...');
      }
    }
  }

  static void openHomePage(BuildContext context, Widget widget) {
    Navigator.pop(
        context,
        MaterialPageRoute(
            builder: (_) => kIsWeb
                ? HomeWebScreen()
                : NavigationScreen(
                    screen: widget,
                  )));
  }

  // endregion

  /// Logout connected [User]
  static Future<void> disconnect() async {
    await _auth.signOut();
    return;
  }

  /// Get Current connected [User]
  static User? get user => _auth.currentUser;
}
