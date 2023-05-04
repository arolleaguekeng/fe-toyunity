import 'package:cloud_firestore/cloud_firestore.dart';

class ToyModel {
  final String id;
  final String name;
  final String uid;
  final String description;
  final String color;
  final double price;
  final String status;
  final String? createdAt;
  final String? updatedAt;
  List<String> images = ["assets/images/png/plant2.jpg"];
  List<double> coordinates = [1,1];

  factory ToyModel.fromJson(dynamic json) {
    return ToyModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
      price: json['price'] as double,
      status: json['status'] as String,
      uid: json['uid'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      images: (json['image'] as List<dynamic>)?.map((e) => e.toString()).toList() ?? [],
      coordinates:(json['coordinates'] as List<dynamic>)?.map((e) => e as double).toList() ?? [],
    );
  }
Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'uid': uid,
      'description': description,
      'color': color,
      'price': price,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'image': images,
      'coordinates': coordinates,
    };
  }
  ToyModel({
    this.id = '',
    required this.uid,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.color,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.coordinates,
  });

  static List<ToyModel> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) => ToyModel.fromJson(data)).toList();
  }

  static ToyModel recipesFromSnapshotSingle(snapshot) {
    return snapshot.map((data) => ToyModel.fromJson(data));
  }
}

class ToyModelCart extends ToyModel {
  int quantity = 1;
  void setquantity(int quantity) {
    this.quantity = quantity;
  }

  int getquantity() {
    return this.quantity;
  }

  ToyModelCart({
    required super.id,
    required super.uid,
    required super.name,
    required super.description,
    required super.price,
    required super.images,
    this.quantity = 1,
    required super.createdAt,
    required super.color,
    required super.status,
    required super.updatedAt, required super.coordinates,
  });
  
  @override String toString() {
    // TODO: implement toString
    return ("id" + id + name);
  }
}
