import 'package:flutter/material.dart';

class Speaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speaker Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Helvetica',
      ),
      home: SpeakerPage(title: 'Speaker Page'),
    );
  }
}

class SpeakerPage extends StatefulWidget {
  SpeakerPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SpeakerPageState createState() => _SpeakerPageState();
}

class _SpeakerPageState extends State<SpeakerPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        Container(color: Colors.black87.withOpacity(0.8)),
        ClipPath(
          child: Container(color: Colors.redAccent[700].withOpacity(0.8)),
          clipper: getClipper(),
        ),
        Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.height / 9,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://scontent.fcai20-2.fna.fbcdn.net/v/t1.0-9/112229139_3184460491591963_8067531204849030225_o.jpg?_nc_cat=111&ccb=2&_nc_sid=174925&_nc_ohc=DIrmDVz6E_YAX9BUIY3&_nc_ht=scontent.fcai20-2.fna&oh=eed207f7d765a348749a74480b9a9b45&oe=5FC88740'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 40.0),
                Text(
                  'Ahmed El-Agroudy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'A professional time waster🏅',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 35.0),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21.0,
                    ),
                  ),
                ),
              ],
            ))
      ],
    ));
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
