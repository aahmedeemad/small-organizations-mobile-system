
 import 'package:flutter/material.dart';
class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}