import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smallorgsys/models/speaker.dart';

class SpeakersController with ChangeNotifier {
  List<Speaker> _speakersList = [];
  Speaker speaker;
  void addSpeakers(Speaker speaker) {
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
    // http.put(
    //   'https://tedxmiu-11c76-default-rtdb.firebaseio.com/speakers/-MT3Ff8P197ctsy_yV7E.json',
    //   body: json.encode(
    //     {
    //       'name': "Speaker 2",
    //       'imagePath': "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    //       'bio': "Speaker Bio 2",
    //       'from': "08:00",
    //       'to': "08:30",
    //       'slogan': "Speaker 2 slogan",
    //       'fullDescription': "Speaker 2 fullDescription",
    //       'MT3E2UgRRA_n7ulFF_s': {
    //         "date": "20-10-2020",
    //         "description": "EVENT DESC 1 From database",
    //         "imagePath":
    //             "https://upload.wikimedia.org/wikipedia/commons/3/3f/TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg",
    //         "locationName": "MIUU",
    //         "locationUrl": "https://goo.gl/maps/7zPhKwbhbqyBnPYU6",
    //         "title": "Super Nova"
    //       }
    //     },
    //   ),
    // );
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

  List<Speaker> get speakers {
    return [..._speakersList];
  }

  Speaker findById(String id) {
    return _speakersList.firstWhere((events) => events.id == id);
  }

  Future<void> fetchAndSetSpeakers(eventID) async {
    try {
      print(
          'https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList/$eventID.json');
      final response = await http.get(
          'https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList/$eventID.json');
      final dbData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<Speaker> dbSpeakers = [];
      dbData.forEach((key, data) {
        dbSpeakers.add(
          Speaker(
              id: key,
              name: data['name'],
              bio: data['bio'],
              from: data['from'],
              to: data['to'],
              imagePath: data['imagePath']),
        );
      });
      print(dbSpeakers[0].imagePath);
      _speakersList = dbSpeakers;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<void> fetchSpeaker(speakerID) async {
    try {
      print(
          'https://tedxmiu-11c76-default-rtdb.firebaseio.com/speakers/$speakerID.json');
      final response = await http.get(
          'https://tedxmiu-11c76-default-rtdb.firebaseio.com/speakers/$speakerID.json');
      final dbData = jsonDecode(response.body) as Map<String, dynamic>;
      print(dbData);
      speaker = Speaker(
          id: speakerID,
          name: dbData['name'],
          bio: dbData['bio'],
          from: dbData['from'],
          to: dbData['to'],
          imagePath: dbData['imagePath'],
          slogan: dbData['slogan'],
          fullDescription: dbData['fullDescription']);
      // final List<Speaker> dbSpeakers = [];
      // dbData.forEach((key, data) {
      //   dbSpeakers.add(
      //     Speaker(
      //       name: data['name'],
      //       bio: data['bio'],
      //       from: data['from'],
      //       to: data['to'],
      //       imagePath: data['imagePath'],
      //       slogan: data['slogan'],
      //       fullDescription: data['fullDescription'],
      //     ),
      //   );
      // });
      // print(dbSpeakers[0].imagePath);
      // _speakersList = dbSpeakers;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
