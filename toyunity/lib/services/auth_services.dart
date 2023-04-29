import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import '../models/user_model.dart';
import '../screens/navigations/navigation_screen.dart';
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
  static Future<void> validateOtp(String smsCode, String verificationId) async {
    final _credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await _auth.signInWithCredential(_credential);
    return;
  }
  // endregion

  static Future<void> addUser(User currentUser) async {
    DocumentReference userRef =
        firestore.collection('users').doc(currentUser.uid);

    await userRef.set({
      'displayName': currentUser.displayName,
      'email': currentUser.email,
      'photoUrl': currentUser.photoURL
    });
  }

  // Connexion with google account
  static Future<UserCredential> signInWithGoogle(
      {required BuildContext context, required Widget widget}) async {
    if (kIsWeb) {
      var userCredential = await _auth.signInWithPopup(googleProvider);
      await addUsers(userCredential, context, widget);
      return userCredential;
    }

    // start authentification Flux
    final googleUser = await _googleSignIn.signIn();

    // get authorisation details of demand
    final googleAuth = await googleUser!.authentication;

    // Create new identified
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await addUsers(userCredential, context, widget);
    // return user id
    return await _auth.signInWithCredential(credential);
  }

  static Future<void> addUsers(UserCredential userCredential,
      BuildContext context, Widget widget) async {
    var uid = userCredential.user!.uid;
    DocumentSnapshot userExist =
        await firestore.collection('users').doc(uid).get();
    if (userExist.exists) {
      await addUser(userCredential.user!);
      print("User Already Exists in Database");
      var userData = await ApiUser.login(uid);
      MyApp.currentUser = userData!;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => NavigationScreen(
                    screen: widget,
                  )));
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
      var userData = await ApiUser.signup(userModel);
      await addUser(userCredential.user!);
      MyApp.currentUser = userData;
    }
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
