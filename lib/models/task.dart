import 'package:flutter/material.dart';

class Task {
  final String title;
  final String assignedto;
  final String description;
  final String assignedby;
  final String status;
  Task({
    @required this.title,
    @required this.assignedto,
    @required this.description,
    @required this.assignedby,
    @required this.status,
  });
}
