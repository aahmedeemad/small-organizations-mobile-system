import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/providers/auth.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                  onPressed: () {}, child: Text("change profile picture")),
              FlatButton(onPressed: () {}, child: Text("Theme")),
              FlatButton(onPressed: () {}, child: Text("About")),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                  child: Text("logout"))
            ]),
      ),
    );
  }
}
