import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventsController with ChangeNotifier {
  List<Event> _eventsList = [];

  void addEvents() async {
    // // for (int i = 1; i < 10; i++) {

    // // Event event = Event(
    // //     date: "20-10-2020",
    // //     title: "Event 0",
    // //     imagePath:
    // //         "https://image.freepik.com/free-photo/image-human-brain_99433-298.jpg",
    // //     description: "Event 0 desc",
    // //     locationName: "Ay 7ta",
    // //     locationUrl: "https://goo.gl/maps/7zPhKwbhbqyBnPYU6",
    // //     latitude: 30.1701457,
    // //     longitude: 31.4896677);
    // // http
    // //     .post(
    // //   'https://tedxmiu-11c76-default-rtdb.firebaseio.com/events.json',
    // //   body: json.encode(
    // //     {
    // //       'title': event.title,
    // //       'imagePath': event.imagePath,
    // //       'description': event.description,
    // //       'date': "20-10-2020",
    // //       'locationName': event.locationName,
    // //       'locationUrl': event.locationUrl,
    // //       'latitude': event.latitude,
    // //       'longitude': event.longitude,
    // //     },
    // //   ),
    // // )
    // //     .then((res) {
    // //   print(res.statusCode);
    // // });
    // // }
    // // for (int i = 0; i < 10; i++) {
    // final response = await http
    //     .get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/events.json');
    // final dbData = jsonDecode(response.body) as Map<String, dynamic>;
    // print(dbData);
    // dbData.forEach((key, data) {
    //   print(dbData['title']);
    //   //   http.post(
    //   //     'https://tedxmiu-11c76-default-rtdb.firebaseio.com/speakers.json',
    //   //     body: json.encode(
    //   //       {
    //   //         'name': "Speaker 1",
    //   //         'imagePath': "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    //   //         'bio': "Speaker Bio 1",
    //   //         'from': "08:00",
    //   //         'to': "08:30",
    //   //         'slogan': "Speaker 1 slogan",
    //   //         'fullDescription': "Speaker 1 fullDescription",
    //   //         key: {
    //   //           "date": "20-10-2020",
    //   //           "description": data['description'],
    //   //           "imagePath": data['imagePath'],
    //   //           "locationName": data['locationName'],
    //   //           "locationUrl": data['locationUrl'],
    //   //           "title": data['title']
    //   //         }
    //   //       },
    //   //     ),
    //   //   );

    //   http.put(
    //     'https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList.json',
    //     body: {'aa': 111},
    //   );

    //   http.put(
    //     'https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList/$key.json',
    //     body: json.encode(
    //       {
    //         //   UniqueKey().toString(): {
    //         //     "imagePath":
    //         //         "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    //         //     "name": "Speaker 1",
    //         //     "bio": "Speaker Bio 1",
    //         //     "from": "08:00",
    //         //     "to": "08:30",
    //         //   }
    //         '-MT3Ff8P197ctsy_yV7E': {
    //           "imagePath":
    //               "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    //           "name": "Speaker 1",
    //           "bio": "Speaker Bio 1",
    //           "from": "08:00",
    //           "to": "08:30",
    //         }
    //       },
    //     ),
    //   );
    // });
    // // http.post(
    // //   'https://tedxmiu-11c76-default-rtdb.firebaseio.com/speakers.json',
    // //   body: json.encode(
    // //     {
    // //       'name': "Speaker $i",
    // //       'imagePath': "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    // //       'bio': "Speaker Bio $i",
    // //       'from': "08:00",
    // //       'to': "08:30",
    // //       'slogan': "Speaker $i slogan",
    // //       'fullDescription': "Speaker $i fullDescription",
    // //       'MT3E2UgRRA_n7ulFF_s': {
    // //         "date": "20-10-2020",
    // //         "description": "EVENT DESC 1 From database",
    // //         "imagePath":
    // //             "https://lh3.googleusercontent.com/proxy/h-An5zY0koNg6P1kOeRjT98hWuf4frENaxH6k_L0PepHKsW2AZ6myURFfaIchXdMhOm414ULiZauI-WsY3zsWQQmmCUKKM3fZRA7aNw1xej7qQ",
    // //         "locationName": "MIUU",
    // //         "locationUrl": "https://goo.gl/maps/7zPhKwbhbqyBnPYU6",
    // //         "title": "Super Nova"
    // //       }
    // //     },
    // //   ),
    // // );
    // // }
    // // http.put(
    // //   'https://tedxmiu-11c76-default-rtdb.firebaseio.com/eventSpeakersList/-MT3E2UgRRA_n7ulFF_s.json',
    // //   body: json.encode(
    // //     {
    // //       '-MT3Ff87-Fd91FbsnjmC': {
    // //         "imagePath": "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    // //         "name": "Speaker 4",
    // //         "bio": "Speaker Bio 4",
    // //         "from": "08:00",
    // //         "to": "08:30",
    // //       },
    // //       '-MT3Ff8P197ctsy_yV7E': {
    // //         "imagePath": "https://upload.wikimedia.org/wikipedia/commons/3/3f/",
    // //         "name": "Speaker 1",
    // //         "bio": "Speaker Bio 1",
    // //         "from": "08:00",
    // //         "to": "08:30",
    // //       }
    // //     },
    // //   ),
    // // );
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

  Future<void> fetchAndSetEvents() async {
    // addEvents();
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
          longitude: data['longitude'],
          latitude: data['latitude'],
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
