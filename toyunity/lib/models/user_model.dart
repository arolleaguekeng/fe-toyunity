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

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      uid: json['uid'] as String,
      fullName: json['fullName'] as String?,
      username: json['username'] as String,
      email: json['email'] as String?,
      hasPassword: json['hash_password'] as String?,
      phone: json['phone'] as String?,
      role: json['role'] as String?,
      image: json['image'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
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
    return 'User {uid: $uid, username: $username,}';
  }
}
