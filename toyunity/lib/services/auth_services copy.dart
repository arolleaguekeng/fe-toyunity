import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


/// Firebase user authentification manager
class AuthService{
  static final _auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static GoogleAuthProvider googleProvider = GoogleAuthProvider();

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

  // region Google Sign in

  // Connexion with google account
  static Future signInWithGoogle(context,page) async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if(googleUser == null){
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist = await firestore.collection('users').doc(userCredential.user!.uid).get();

    if(userExist.exists){
      print("User Already Exists in Database");
    }else{
       await firestore.collection('users').doc(userCredential.user!.uid).set({
      'email':userCredential.user!.email,
      'name':userCredential.user!.displayName,
      'image':userCredential.user!.photoURL,
      'uid':userCredential.user!.uid,
      'date':DateTime.now(),
    });
    }

   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>page()), (route) => false);
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
