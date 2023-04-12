import 'package:toyunity/models/toy.dart';

class Categorie {
  final String name;
  final List<Toy> toy;
  bool isSelected;
  Categorie({required this.name, required this.toy, required this.isSelected});
}

List<Categorie> categories = [
  Categorie(
    name: 'All',
    toy: [
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Boston Ivy',
          desc: 'Climbs their storied walls.',
          price: '\$13'),
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Green Succulent',
          price: '\$11',
          desc: 'Store water in arid climates.'),
      Toy(
          name: 'Dieffenbachia Bonsa',
          price: '\$10',
          imgUrl: 'plant3.jpg',
          desc: 'large group of beautiful tropical perennials'),
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Plantagenia',
          desc: 'Grown for their foliage rather than blooms',
          price: '\$9'),
    ],
    isSelected: false,
  ),
  Categorie(
    name: 'Monsteria',
    toy: [
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Boston Ivy',
          desc: 'Climbs their storied walls.',
          price: '\$13'),
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Green Succulent',
          price: '\$11',
          desc: 'Store water in arid climates.'),
    ],
    isSelected: false,
  ),
  Categorie(
    name: 'Aloe',
    toy: [
      Toy(
          name: 'Dieffenbachia Bonsa',
          price: '\$10',
          imgUrl: 'plant3.jpg',
          desc: 'large group of beautiful tropical perennials'),
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Plantagenia',
          desc: 'Grown for their foliage rather than blooms',
          price: '\$9'),
    ],
    isSelected: false,
  ),
  Categorie(
    name: 'Palm',
    toy: [
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Plantagenia',
          desc: 'Grown for their foliage rather than blooms',
          price: '\$9'),
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Green Succulent',
          price: '\$11',
          desc: 'Store water in arid climates.'),
    ],
    isSelected: false,
  ),
  Categorie(
    name: 'Yamm',
    toy: [
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Boston Ivy',
          desc: 'Climbs their storied walls.',
          price: '\$13'),
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Plantagenia',
          desc: 'Grown for their foliage rather than blooms',
          price: '\$9'),
    ],
    isSelected: false,
  ),
  Categorie(
    name: 'Other',
    toy: [
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Boston Ivy',
          desc: 'Climbs their storied walls.',
          price: '\$13'),
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Green Succulent',
          price: '\$11',
          desc: 'Store water in arid climates.'),
    ],
    isSelected: false,
  ),
  Categorie(
    name: 'OK',
    toy: [
      Toy(
          imgUrl: 'plant3.jpg',
          name: 'Boston Ivy',
          desc: 'Climbs their storied walls.',
          price: '\$13'),
      Toy(
          name: 'Dieffenbachia Bonsa',
          price: '\$10',
          imgUrl: 'plant3.jpg',
          desc: 'large group of beautiful tropical perennials'),
    ],
    isSelected: false,
  ),
];
