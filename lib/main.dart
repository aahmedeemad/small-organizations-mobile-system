import 'package:flutter/material.dart';
import 'package:smallorgsys/screens/about_us.dart';
import 'package:smallorgsys/screens/admin_home_page.dart';
import 'package:smallorgsys/screens/board.dart';
import 'package:smallorgsys/screens/event_details.dart';
import 'package:smallorgsys/screens/events.dart';
import 'package:smallorgsys/screens/speaker_page.dart';
import 'screens/login.dart';

void main() async {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tedx MIU',
      routes: {
        '/': (context) => EventsPage(),
        '/eventDetails': (context) => EventDetailsPage(),
        '/login': (context) => LoginPage(),
        '/adminHomePage': (context) => AdminHomePage(),
        '/board': (context) => BoardPage(),
        '/aboutus': (context) => AboutUsPage(),
        '/speakerPage': (context) => SpeakerPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      // home: EventsPage(),
    );
  }
}
