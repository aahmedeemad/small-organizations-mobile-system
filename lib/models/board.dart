import 'package:flutter/material.dart';

class Board {
  final String id;
  final String name;
  final String position;
  final String imagePath;
  final String year;

  Board({
    @required this.id,
    @required this.name,
    @required this.position,
    @required this.imagePath,
    @required this.year,
  });
}
