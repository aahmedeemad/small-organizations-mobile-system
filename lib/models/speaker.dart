import 'package:flutter/material.dart';

class Speaker {
  final String name;
  final String bio;
  final String imagePath;
  final String from;
  final String to;
  String slogan;
  final String fullDescription;
  Speaker({
    @required this.name,
    @required this.bio,
    @required this.imagePath,
    @required this.from,
    @required this.to,
    @required this.fullDescription,
    this.slogan,
  });
}
