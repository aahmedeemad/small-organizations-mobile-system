import 'package:flutter/material.dart';

class Board {
  final String id;
  final String name;
  final String position;
  final String imagePath;
  final int order;

  Board({
    @required this.id,
    @required this.name,
    @required this.position,
    @required this.imagePath,
    @required this.order,
  });
}
