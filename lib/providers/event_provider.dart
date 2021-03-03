import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventsController with ChangeNotifier {
  List<Event> _eventsList = [];

  void addEvents() async {
    // final response = await http
    //     .get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/events.json');
    // final dbData = jsonDecode(response.body) as Map<String, dynamic>;
    // dbData.forEach((key, data) {
    //   http.post(
    //     'https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList/$key.json',
    //     body: json.encode(
    //       {
    //         "imagePath":
    //             "https://firebasestorage.googleapis.com/v0/b/tedxmiu-11c76.appspot.com/o/speaker1.jpg?alt=media&token=18d07bc8-d575-45b0-a3a5-9159e90f4f75",
    //         "name": "Speaker 1",
    //         "bio": "Speaker Bio 1",
    //         "from": "08:00",
    //         "to": "08:30",
    //       },
    //     ),
    //   );
    //   http.post(
    //     'https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList/$key.json',
    //     body: json.encode(
    //       {
    //         "imagePath":
    //             "https://firebasestorage.googleapis.com/v0/b/tedxmiu-11c76.appspot.com/o/speaker1.jpg?alt=media&token=18d07bc8-d575-45b0-a3a5-9159e90f4f75",
    //         "name": "Speaker 2",
    //         "bio": "Speaker Bio 2",
    //         "from": "08:30",
    //         "to": "09:00",
    //       },
    //     ),
    //   );
    //   http
    //       .get(
    //           "https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList/$key.json")
    //       .then((res) {
    //     Map<String, dynamic> d = jsonDecode(res.body) as Map<String, dynamic>;
    //     d.forEach((k, v) {
    //       print(v['name']);
    //       if (v['name'] == "Speaker 1") {
    //         http.put(
    //           'https://tedxmiu-11c76-default-rtdb.firebaseio.com/speakers/$k.json',
    //           body: json.encode(
    //             {
    //               'name': "Speaker 1",
    //               'imagePath':
    //                   "https://firebasestorage.googleapis.com/v0/b/tedxmiu-11c76.appspot.com/o/speaker1.jpg?alt=media&token=18d07bc8-d575-45b0-a3a5-9159e90f4f75",
    //               'bio': "Speaker Bio 1",
    //               'from': "08:00",
    //               'to': "08:30",
    //               'slogan': "Speaker 1 slogan",
    //               'fullDescription': "Speaker 1 fullDescription",
    //               key: {
    //                 "date": "20-10-2020",
    //                 "description": "EVENT DESC 1 From database",
    //                 "imagePath":
    //                     "https://image.freepik.com/free-photo/image-human-brain_99433-298.jpg",
    //                 "locationName": "MIUU",
    //                 "locationUrl": "https://goo.gl/maps/7zPhKwbhbqyBnPYU6",
    //                 "title": "Super Nova"
    //               }
    //             },
    //           ),
    //         );
    //       } else {
    //         http.put(
    //           'https://tedxmiu-11c76-default-rtdb.firebaseio.com/speakers/$k.json',
    //           body: json.encode(
    //             {
    //               'name': "Speaker 2",
    //               'imagePath':
    //                   "https://firebasestorage.googleapis.com/v0/b/tedxmiu-11c76.appspot.com/o/speaker1.jpg?alt=media&token=18d07bc8-d575-45b0-a3a5-9159e90f4f75",
    //               'bio': "Speaker Bio 2",
    //               'from': "08:30",
    //               'to': "09:00",
    //               'slogan': "Speaker 2 slogan",
    //               'fullDescription': "Speaker 2 fullDescription",
    //               key: {
    //                 "date": "20-10-2020",
    //                 "description": "EVENT DESC 2 From database",
    //                 "imagePath":
    //                     "https://image.freepik.com/free-photo/image-human-brain_99433-298.jpg",
    //                 "locationName": "MIUU",
    //                 "locationUrl": "https://goo.gl/maps/7zPhKwbhbqyBnPYU6",
    //                 "title": "Super Nova"
    //               }
    //             },
    //           ),
    //         );
    //       }
    //     });
    //   });
    // });
  }

  Future userAttendEvent(eventId, userId) async {
    await http.patch(
      'https://tedxmiu-11c76-default-rtdb.firebaseio.com/usersAttendEvents/$userId.json',
      body: json.encode({eventId: true}),
    );
    final res = await http.get(
        'https://tedxmiu-11c76-default-rtdb.firebaseio.com/users/$userId.json');
    if (res.statusCode == 200) {
      var dbData = jsonDecode(res.body);
      return {
        'success': true,
        'user_name': dbData['name'],
        'user_imagePath': dbData['imagePath']
      };
    } else
      return {'success': false};
  }

  List<Event> get events {
    return [..._eventsList];
  }

  Event findById(String id) {
    return _eventsList.firstWhere((events) => events.id == id);
  }

  Future<bool> fetchAndSetEvents() async {
    try {
      final response = await http
          .get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/events.json');
      if (response.statusCode == 200 && response.body != null) {
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
            longitude: data['longitude'],
            latitude: data['latitude'],
          ));
        });
        //print(dbEvents[0].imagePath);
        _eventsList = dbEvents;
        notifyListeners();
        return true;
      }
      return false;
    } on Exception catch (e) {
      print(e.toString());
      // throw (e);
      return false;
    }
  }
}
