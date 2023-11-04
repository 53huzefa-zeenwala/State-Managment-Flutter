import 'package:flutter/foundation.dart' show immutable;

@immutable
class GroceryModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const GroceryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}
