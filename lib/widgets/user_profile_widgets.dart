import 'package:flutter/material.dart';

Widget eventCard() {
  return InkWell(
    onTap: () {},
    child: Container(
        width: 50,
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.red,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.event, size: 70),
                title: Text('Upcoming Events',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        )),
  );
}

Widget profilePic({@required image}) {
  return Container(
    width: 150.0,
    height: 150.0,
    decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.all(Radius.circular(75.0)),
        boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
  );
}

Widget homeCard({@required word, @required icon}) {
  return Card(
    margin: EdgeInsets.all(10.0),
    color: Colors.grey[300],
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(icon, size: 30.0),
          Text(word, style: TextStyle(fontSize: 18, color: Colors.black)),
        ],
      ),
    ),
  );
}
