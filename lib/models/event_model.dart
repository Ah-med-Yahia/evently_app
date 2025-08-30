import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/category_model.dart';

class EventModel {
  String id;
  String userId;
  String title;
  String description;
  DateTime dateTime;
  CategoryModel category;
  double longtiude;
  double latitude;
  String address;
  EventModel(
      {required this.dateTime,
      required this.description,
      required this.title,
      required this.category,
      required this.userId,
      required this.longtiude,
      required this.latitude,
      required this.address,
      this.id = ''});

  EventModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          userId: json['userId'],
          category: CategoryModel.categories
              .firstWhere((category) => category.id == json['categoryId']),
          title: json['title'],
          description: json['description'],
          latitude: json['latitude'],
          longtiude: json['longtiude'],
          address: json['address'],
          dateTime: (json['timestamp'] as Timestamp).toDate(),
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'categoryId': category.id,
        'title': title,
        'description': description,
        'latitude':latitude,
        'address':address,
        'longtiude':longtiude,
        'timestamp': Timestamp.fromDate(dateTime),
      };
}
