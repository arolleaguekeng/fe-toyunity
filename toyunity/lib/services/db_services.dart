import 'dart:io';
import 'dart:typed_data';

import 'package:toyunity/models/toy_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

/// Data operations manager.
///
/// You can upload image on firebase by calling [uploadFile].
/// For example:
///
/// ```dart
/// DataBaseService database =DataBaseService();
/// database.uploadFile(file, fileWeb);
///
/// database.addToy(toyModel);
/// ```
class DataBaseService {
  final CollectionReference _toys =
      FirebaseFirestore.instance.collection('toys');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload a [File] to Firebase Starage.
  Future<String> uploadFile(File file, XFile fileWeb) async {
    Reference reference = _storage.ref().child('toys/${DateTime.now()}.png');
    Uint8List imageTosave = await fileWeb.readAsBytes();
    SettableMetadata metaData = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask = kIsWeb
        ? reference.putData(imageTosave, metaData)
        : reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  // Add toys in FireStore Database
  /// Write a [ToyModel] to Firebase Firestore.
  void addToy(ToyModel toyModel) {
    _toys.add({
      "userId": toyModel.uid,
      "name": toyModel.name,
      "description": toyModel.name,
      "price": toyModel.price,
      "images": toyModel.images,
      "pCreatedAt": FieldValue.serverTimestamp()
    });
  }

  /// Get all toys in Firestore and map to  [ToyModel] to Firebase Firestore.
  // Future<List<ToyModel>> getAllToys() async {
  //   List<ToyModel> listeDesObjets = [];

  //   QuerySnapshot querySnapshot =
  //       await FirebaseFirestore.instance.collection('toys').get();

  //   for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
  //     ToyModel objet = ToyModel.fromFirestore(documentSnapshot);
  //     listeDesObjets.add(objet);
  //   }
  //   print("************************ toys list********************");
  //   print(listeDesObjets);
  //   return listeDesObjets;
  // }
}
