import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String committee;
  final String joinAt;
  final String leftAt;
  final String privilege;
  final String birthDate;
  final String token;
  final String imagePath;
  final String phone;
  final int rating;

  // final List<Task> task;
  User({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.committee,
    @required this.joinAt,
    @required this.leftAt,
    @required this.privilege,
    @required this.birthDate,
    @required this.token,
    @required this.imagePath,
    @required this.phone,
    @required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': this.token,
      'id': this.id,
      'name': this.name,
      'email': this.email,
      'privilege': this.privilege,
      'imagePath': this.imagePath,
      'birthDate': this.birthDate,
      'leftAt': this.leftAt,
      'joinAt': this.joinAt,
      'committee': this.committee,
      'phone': this.phone,
      'rating': this.rating,
    };
  }
}
