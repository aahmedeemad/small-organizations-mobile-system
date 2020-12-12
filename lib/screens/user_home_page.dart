import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Center(
          child: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(25.0),
                child: profilePic(),
              ),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      "Fady Bassel",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "IT member",
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      tooltip: 'Qr Code',
                      icon: Icon(Icons.qr_code),
                      iconSize: 30,
                      onPressed: () {
                        showQr(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          homeCard(word: 'tasks done 30%', icon: Icons.pending_actions),
          homeCard(
              word: 'Attendance Meetings 70%', icon: Icons.pending_actions),
          homeCard(word: 'Attendance Events 90%', icon: Icons.pending_actions),
          eventCard(),
        ],
      )),
    );*/
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(color: Colors.black87.withOpacity(0.8)),
        ClipPath(
          child: Container(color: Colors.redAccent[700].withOpacity(0.8)),
          clipper: getClipper(),
        ),
        Center(
            child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(25.0),
                  child: profilePic(),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        "Fady Bassel",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "IT member",
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        tooltip: 'Qr Code',
                        icon: Icon(Icons.qr_code),
                        iconSize: 30,
                        onPressed: () {
                          showQr(context);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            homeCard(word: ' Tasks Done 30%', icon: Icons.pending_actions),
            homeCard(
                word: ' Attendance Meetings 70%', icon: Icons.pending_actions),
            homeCard(
                word: ' Attendance Events 90%', icon: Icons.pending_actions),
            eventCard(),
          ],
        )),
      ],
    ));
  }

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

  Widget profilePic() {
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, size: 30.0),
            Text(word, style: TextStyle(fontSize: 18, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Future showQr(context) {
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
