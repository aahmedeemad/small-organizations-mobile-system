import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  BoardPage();
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
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

  Widget boardWidget(
      {@required imagePath, @required name, @required position}) {
    return Column(
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
    );
  }
}
