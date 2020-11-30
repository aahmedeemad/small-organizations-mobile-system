import 'package:flutter/material.dart';
import 'package:smallorgsys/models/task.dart';

class User {
  final String name;
  final String imagepath;
  final String qrCode;
  final List<Task> task;
  User({
    @required this.name,
    @required this.imagepath,
    @required this.qrCode,
    @required this.task,
  });
}
