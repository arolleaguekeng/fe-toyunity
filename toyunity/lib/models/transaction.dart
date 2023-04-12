import 'package:toyunity/models/toy_model.dart';
import 'package:toyunity/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Transaction {
  final ToyModel toy;
  final UserModel user;
  final String montant;
  final Timestamp date;
  final String nom;

  Transaction(
      {required this.toy,
      required this.user,
      required this.montant,
      required this.date,
      required this.nom});
}
