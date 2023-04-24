import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String? fullName;
  String username;
  String? email;
  String? hasPassword;
  String? phone;
  String? role;
  String? image;
  String? city;
  String? state;
  String? country;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.username,
    required this.email,
    required this.hasPassword,
    required this.phone,
    required this.role,
    required this.image,
    required this.city,
    required this.state,
    required this.country,
  });

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      uid: snapshot['uid'],
      fullName: snapshot['fullName'],
      username: snapshot['username'],
      email: snapshot['email'],
      hasPassword: snapshot['hash_password'],
      phone: snapshot['phone'],
      role: snapshot['role'],
      image: snapshot['image'],
      city: snapshot['city'],
      state: snapshot['state'],
      country: snapshot['country'],
    );
  }

  static List<UserModel> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) => UserModel.fromJson(data)).toList();
  }

  static UserModel recipesFromSnapshotSingle(snapshot) {
    return snapshot.map((data) => UserModel.fromJson(data));
  }

  @override
  String toString() {
    return 'Assuré {uid: $email, image: $username,}';
  }
}
