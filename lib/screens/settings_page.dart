import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return Container(
      child: Center(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          FlatButton(onPressed: (){}, child: Text("change profile picture")),
          FlatButton(onPressed: (){}, child: Text("Theme")),
          FlatButton(onPressed: (){}, child: Text("About")),
          FlatButton(onPressed: (){}, child: Text("logout"))
        ]),
      ),
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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                    onPressed: () {}, child: Text("Change Profile Picture")),
                FlatButton(onPressed: () {}, child: Text("Theme")),
                FlatButton(onPressed: () {}, child: Text("About")),
                FlatButton(onPressed: () {}, child: Text("logout")),
              ]),
        ),
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
