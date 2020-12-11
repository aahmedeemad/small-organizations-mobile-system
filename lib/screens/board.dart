import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  BoardPage();
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  /*Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Board'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return boardWidget(
            imagePath:
                "https://scontent.fcai20-2.fna.fbcdn.net/v/t1.0-9/112229139_3184460491591963_8067531204849030225_o.jpg?_nc_cat=111&ccb=2&_nc_sid=174925&_nc_ohc=DIrmDVz6E_YAX9BUIY3&_nc_ht=scontent.fcai20-2.fna&oh=eed207f7d765a348749a74480b9a9b45&oe=5FC88740",
            name: "Ahmed Emad",
            position: "President",
          );
        },
      ),
    );
  }
  */

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Board'),
        ),
        body: Stack(
          children: <Widget>[
            Container(color: Colors.black87.withOpacity(0.8)),
            ClipPath(
              child: Container(color: Colors.redAccent[700].withOpacity(0.8)),
              clipper: getClipper(),
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return boardWidget(
                  imagePath:
                      "https://content.fortune.com/wp-content/uploads/2017/02/506802698.jpg",
                  name: "Elon Musk",
                  position: "President",
                );
              },
            ),
          ],
        ));
  }

  Widget boardWidget(
      {@required imagePath, @required name, @required position}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10.0),
          Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: NetworkImage(imagePath), fit: BoxFit.cover),
              borderRadius: BorderRadius.all(Radius.circular(75.0)),
              boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)],
            ),
          ),
          SizedBox(height: 15.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            position,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
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
