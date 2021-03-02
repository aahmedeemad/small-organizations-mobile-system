import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  bool status;
  Task({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.status,
  });

  toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'status': this.status,
    };
  }
}
