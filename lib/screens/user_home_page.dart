import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
          child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(25.0),
                child: ProfilePic(),
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      "Fady Bassel",
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      tooltip: 'Qr Code',
                      icon: Icon(Icons.qr_code),
                      iconSize: 30,
                      onPressed: () {
                        ShowQr(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          HomeCard(word: 'tasks done 30%', icon: Icons.pending_actions),
          HomeCard(
              word: 'Attendance Meetings 70%', icon: Icons.pending_actions),
          HomeCard(word: 'Attendance Events 90%', icon: Icons.pending_actions)
        ],
      )),
    );
  }
}

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(
                image: NetworkImage(
                    'https://avatars0.githubusercontent.com/u/56454311?s=400&u=6a76d8c13ad043b067e0227e27c3ea84e3bbb88e&v=4'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(75.0)),
            boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]));
  }
}

Widget HomeCard({word, icon}) {
  return Card(
      margin: EdgeInsets.all(15.0),
      color: Colors.grey[300],
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 60.0,
          ),
          Text(
            word,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ],
      ));
}

Future ShowQr(context) {
  return showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          "Your QR Code",
          textAlign: TextAlign.center,
        ),
        content: Container(
          child: Icon(
            Icons.qr_code,
            size: 200,
          ),
        ),
      ));
}
