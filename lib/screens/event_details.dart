import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class EventDetailsPage extends StatefulWidget {
  EventDetailsPage();

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  Future _allSpeakers;

  @override
  void initState() {
    super.initState();
    // _allSpeakers = getAllSpeakers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Supernova'),
      ),
      body: new ListView(
        children: <Widget>[
          new Image.network(
            'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.fitWidth,
          ),
          new Padding(padding: const EdgeInsets.all(5.0)),
          new Container(
            height: 50,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                new Card(
                  child: new Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: <Widget>[
                        new Icon(Icons.date_range),
                        new Text(
                          '20-10-2020',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.all(2.0),
                ),
                new Card(
                  child: new Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: <Widget>[
                        new Icon(Icons.location_on),
                        new RichText(
                          text: new TextSpan(
                            children: [
                              new TextSpan(text: ' '),
                              new TextSpan(
                                text: 'MIU',
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {},
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(
                left: 7.0, top: 15.0, bottom: 7.0, right: 7.0),
          ),
          new Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: new Text(
              'descriptiondescriptiondescriptiondescriptiondescription'
              'descriptiondescriptiondescriptiondescriptiondescription'
              'descriptiondescriptiondescriptiondescriptiondescription'
              'descriptiondescriptiondescriptiondescriptiondescription'
              'descriptiondescriptiondescriptiondescriptiondescription',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(
                left: 7.0, top: 20.0, bottom: 7.0, right: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Icon(Icons.people),
                new Text(
                  ' Speakers',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            height: 320.0,
            child: ListView(
              children: [
                speaker(
                    imagePath:
                        'https://upload.wikimedia.org/wikipedia/commons/3/3f/'
                        'TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                    name: 'Mark Refaat',
                    bio: 'BioBioBioBioBioBioBioBioBio'
                        'BioBioBioBioBioBioBioBioBioBioBioBioBioBioBio',
                    from: '08:00AM',
                    to: '09:00AM'),
                speaker(
                    imagePath:
                        'https://upload.wikimedia.org/wikipedia/commons/3/3f/'
                        'TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                    name: 'Mark Refaat',
                    bio: 'BioBioBioBioBioBioBioBioBio'
                        'BioBioBioBioBioBioBioBioBioBioBioBioBioBioBio',
                    from: '08:00AM',
                    to: '09:00AM'),
                speaker(
                    imagePath:
                        'https://upload.wikimedia.org/wikipedia/commons/3/3f/'
                        'TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                    name: 'Mark Refaat',
                    bio: 'BioBioBioBioBioBioBioBioBio'
                        'BioBioBioBioBioBioBioBioBioBioBioBioBioBioBio',
                    from: '08:00AM',
                    to: '09:00AM'),
                speaker(
                    imagePath:
                        'https://upload.wikimedia.org/wikipedia/commons/3/3f/'
                        'TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                    name: 'Mark Refaat',
                    bio: 'BioBioBioBioBioBioBioBioBio'
                        'BioBioBioBioBioBioBioBioBioBioBioBioBioBioBio',
                    from: '08:00AM',
                    to: '09:00AM'),
                speaker(
                    imagePath:
                        'https://upload.wikimedia.org/wikipedia/commons/3/3f/'
                        'TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                    name: 'Mark Refaat',
                    bio: 'BioBioBioBioBioBioBioBioBio'
                        'BioBioBioBioBioBioBioBioBioBioBioBioBioBioBio',
                    from: '08:00AM',
                    to: '09:00AM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget speaker(
      {@required imagePath,
      @required name,
      @required bio,
      @required from,
      @required to}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/speakerPage');
      },
      child: new Card(
        child: new ListTile(
          leading: new CircleAvatar(
            backgroundColor: Colors.black87,
            minRadius: 10.0,
            maxRadius: 20.0,
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: new Image.network(
                imagePath,
              ),
            ),
          ),
          title: new Text(name),
          subtitle: new Text(bio),
          trailing: new Text('$from - $to'),
        ),
      ),
    );
  }
}
