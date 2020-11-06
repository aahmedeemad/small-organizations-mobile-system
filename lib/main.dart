import 'package:flutter/material.dart';
import 'package:smallorgsys/screens/aboutus.dart';
import 'package:smallorgsys/screens/speaker_page.dart';
import 'home_page.dart';
import 'screens/login.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Theme',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: Speaker());
  }
}
