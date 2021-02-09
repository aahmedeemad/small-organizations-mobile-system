import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventsController with ChangeNotifier {
  List<Event> _eventsList = [];

  void addEvents(Event event) {
    // http.post(
    //   'https://tedxmiu-11c76-default-rtdb.firebaseio.com/events.json',
    //   body: json.encode(
    //     {
    //       'title': event.title,
    //       'imagePath': event.imagePath,
    //       'description': event.description,
    //       'date': "20-10-2020",
    //       'locationName': event.locationName,
    //       'locationUrl': event.locationUrl,
    //     },
    //   ),
    // );
    // for (int i = 0; i < 10; i++) {
    //   http.post(
    //     'https://tedxmiu-11c76-default-rtdb.firebaseio.com/speakers.json',
    //     body: json.encode(
    //       {
    //         'name': "Speaker $i",
    //         'imagePath': "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    //         'bio': "Speaker Bio $i",
    //         'from': "08:00",
    //         'to': "08:30",
    //         'slogan': "Speaker $i slogan",
    //         'fullDescription': "Speaker $i fullDescription",
    //         'MT3E2UgRRA_n7ulFF_s': {
    //           "date": "20-10-2020",
    //           "description": "EVENT DESC 1 From database",
    //           "imagePath":
    //               "https://lh3.googleusercontent.com/proxy/h-An5zY0koNg6P1kOeRjT98hWuf4frENaxH6k_L0PepHKsW2AZ6myURFfaIchXdMhOm414ULiZauI-WsY3zsWQQmmCUKKM3fZRA7aNw1xej7qQ",
    //           "locationName": "MIUU",
    //           "locationUrl": "https://goo.gl/maps/7zPhKwbhbqyBnPYU6",
    //           "title": "Super Nova"
    //         }
    //       },
    //     ),
    //   );
    // }
    // http.put(
    //   'https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList/-MT3E2UgRRA_n7ulFF_s.json',
    //   body: json.encode(
    //     {
    //       '-MT3Ff87-Fd91FbsnjmC': {
    //         "imagePath": "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    //         "name": "Speaker 4",
    //         "bio": "Speaker Bio 4",
    //         "from": "08:00",
    //         "to": "08:30",
    //       },
    //       '-MT3Ff8P197ctsy_yV7E': {
    //         "imagePath": "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    //         "name": "Speaker 1",
    //         "bio": "Speaker Bio 1",
    //         "from": "08:00",
    //         "to": "08:30",
    //       }
    //     },
    //   ),
    // );

    notifyListeners();
  }

  List<Event> get events {
    return [..._eventsList];
  }

  Event findById(String id) {
    return _eventsList.firstWhere((events) => events.id == id);
  }

  Future<void> fetchAndSetEvents() async {
    try {
      final response = await http
          .get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/events.json');
      final dbData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Event> dbEvents = [];
      dbData.forEach((key, data) {
        dbEvents.add(Event(
          id: key,
          title: data['title'],
          date: data['date'],
          description: data['description'],
          imagePath: data['imagePath'],
          locationName: data['locationName'],
          locationUrl: data['locationUrl'],
        ));
      });
      print(dbEvents[0].imagePath);
      _eventsList = dbEvents;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
