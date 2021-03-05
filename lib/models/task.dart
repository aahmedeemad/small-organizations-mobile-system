import 'package:flutter/material.dart';

class Task {
  final String id;
  final String title;
  final String description;
  bool status;
  final String committee;
  Task({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.status,
    @required this.committee,
  });

  toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'status': this.status,
      'committee': this.committee,
    };
  }
}
