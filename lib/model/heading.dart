import 'package:uuid/uuid.dart';

enum Gender { Male, Female }

class Details {
  Details({
    required this.image,
    required this.title,
    required this.age,
    required this.date,
    required this.description,
    required this.gender,
    required this.breed,
    required this.isPet,
    String? identity,
    this.price,
  }) : id = identity ?? const Uuid().v4();

  final String id;
  List<String> image;
  int? price;
  String title;
  int age;
  String date;
  String description;
  Gender gender;
  String breed;
  bool isPet;
}

class Heading {
  Heading({required this.title, required this.icon, required this.lists});
  String title;
  String icon;
  List<Details> lists;
}

List<int> headingIndex = [0, 0, 0];
