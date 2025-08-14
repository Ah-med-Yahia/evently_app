import 'package:evently_app/utils/app_assets.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  IconData icon;
  CategoryModel(
      {required this.icon,
      required this.id,
      required this.image,
      required this.name});

  static List<CategoryModel> categories = [
    CategoryModel(icon: Icons.sports_basketball, id: '1', image: AppAssets.sportBackground, name: 'Sports'),
    CategoryModel(icon: Icons.cake_outlined, id: '2', image: AppAssets.birthDayBackground, name: 'Birth Day'),
    CategoryModel(icon: Icons.more_time, id: '3', image: AppAssets.meetingBackground, name: 'Meeting'),
  ];
}
