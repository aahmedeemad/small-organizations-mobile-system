import 'package:flutter/material.dart';
import 'package:smallorgsys/models/speaker.dart';

class Event {
  final String id;
  final String title;
  final String imagePath;
  final String description;
  final String date;
  final String locationName;
  final String locationUrl;
  final List<Speaker> speakers;
  Event({
    this.id,
    @required this.title,
    @required this.imagePath,
    @required this.date,
    @required this.description,
    @required this.locationName,
    @required this.locationUrl,
    this.speakers,
  });
}
