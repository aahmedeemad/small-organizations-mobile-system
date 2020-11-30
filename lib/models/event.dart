import 'package:flutter/material.dart';
import 'package:smallorgsys/models/speaker.dart';

class Event {
  final String title;
  final String imagePath;
  final String description;
  final DateTime date;
  final String locationName;
  final String locationUrl;
  final List<Speaker> speakers;
  Event({
    @required this.title,
    @required this.imagePath,
    @required this.date,
    @required this.description,
    @required this.locationName,
    @required this.locationUrl,
    @required this.speakers,
  });
}
