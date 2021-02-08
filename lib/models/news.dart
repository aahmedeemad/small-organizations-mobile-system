import 'package:flutter/material.dart';

class News {
  final String id;
  final String title;
  final String imagePath;
  final String description;
  News({
    this.id,
    @required this.title,
    @required this.imagePath,
    @required this.description,
  });
}
