import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class EventDetailsPage extends StatefulWidget {
  int index;
  EventDetailsPage(this.index);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      appBar: AppBar(
        title: Text('Supernova'),
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: widget.index,
            child: Image.network(
              'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(height: 10.0, width: 10.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        Text(
                          '20-10-2020',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.location_on),
                        InkWell(
                          onTap: () {
                            _launchUrl();
                          },
                          child: Text(
                            'MIU',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25, width: 15),
          Padding(
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
          Padding(
            padding: const EdgeInsets.only(
                left: 7.0, top: 20.0, bottom: 7.0, right: 7.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.people),
                Text(
                  ' Speakers',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return speaker(
                imagePath:
                    'https://upload.wikimedia.org/wikipedia/commons/3/3f/'
                    'TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                name: 'Mark Refaat',
                bio: 'BioBioBioBioBioBioBioBioBio'
                    'BioBioBioBioBioBioBioBioBioBioBioBioBioBioBio',
                from: '08:00AM',
                to: '09:00AM',
              );
            },
          ),
        ],
      ),
    );*/
    return Scaffold(
        appBar: AppBar(
          title: Text('Supernova'),
        ),
        body: Stack(
          children: <Widget>[
            Container(color: Colors.black87.withOpacity(0.8)),
            ClipPath(
              child: Container(color: Colors.redAccent[700].withOpacity(0.8)),
              clipper: getClipper(),
            ),
            ListView(
              children: <Widget>[
                Hero(
                  tag: widget.index,
                  child: Image.network(
                    'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
                    repeat: ImageRepeat.noRepeat,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(height: 10.0, width: 10.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.date_range),
                              Text(
                                '20-10-2020',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              InkWell(
                                onTap: () {
                                  _launchUrl();
                                },
                                child: Text(
                                  'MIU',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25, width: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: new Text(
                    'description description description description description '
                    'description description description description description '
                    'description description description description description '
                    'description description description description description '
                    'description description description description description ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 7.0, top: 20.0, bottom: 7.0, right: 7.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.people),
                      Text(
                        ' Speakers',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return speaker(
                      imagePath:
                          'https://upload.wikimedia.org/wikipedia/commons/3/3f/'
                          'TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                      name: 'Mark Refaat',
                      bio: 'BioBioBioBioBioBioBioBioBio'
                          'BioBioBioBioBioBioBioBioBioBioBioBioBioBioBio',
                      from: '08:00AM',
                      to: '09:00AM',
                    );
                  },
                ),
              ],
            ),
          ],
        ));
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

  void _launchUrl() async {
    if (await launcher.canLaunch('https://goo.gl/maps/7zPhKwbhbqyBnPYU6'))
      await launcher.launch('https://goo.gl/maps/7zPhKwbhbqyBnPYU6');
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
