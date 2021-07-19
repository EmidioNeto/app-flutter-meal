import 'package:flutter/material.dart';

class CategoryFilter {
  final String name;
  final String title;
  final String externalName;
  final String description;
  final IconData icon;

  CategoryFilter(
      {required this.name,
      required this.title,
      required this.externalName,
      required this.description,
      required this.icon});
}
