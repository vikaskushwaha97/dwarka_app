import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final double price;
  final double crossPrice;
  final List<Review> reviews;
  final List<Variant> variants;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.price,
    required this.crossPrice,
    required this.reviews,
    required this.variants,
    required this.category,
    required this.rating,
  });
}

class Review {
  final String userName;
  final String comment;
  final double rating;
  final DateTime date;

  Review({
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
  });
}

class Variant {
  final String name;
  final List<String> options;

  Variant({
    required this.name,
    required this.options,
  });
}
