import 'package:flutter/material.dart';

class Task {
  final String title;
  final int assignedto;
  final String description;
  final int assignedby;
  final bool status;
  Task({
    @required this.title,
    @required this.assignedto,
    @required this.description,
    @required this.assignedby,
    @required this.status,
  });
}
