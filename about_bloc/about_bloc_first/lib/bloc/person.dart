import 'package:flutter/foundation.dart' show immutable;

@immutable
class Person {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String imageUrl;
  final String brewersTips;

  const Person(
      {required this.id,
      required this.name,
      required this.tagline,
      required this.description,
      required this.imageUrl,
      required this.brewersTips});

  Person.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        tagline = json['tagline'] as String,
        description = json['description'] as String,
        imageUrl = json['image_url'] as String,
        brewersTips = json['brewers_tips'] as String;
}
