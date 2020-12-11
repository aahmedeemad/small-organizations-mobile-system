import 'package:flutter/material.dart';
import 'package:smallorgsys/screens/about_us.dart';
import 'package:smallorgsys/screens/add_member.dart';
import 'package:smallorgsys/screens/admin_home_page.dart';
import 'package:smallorgsys/screens/board.dart';
import 'package:smallorgsys/screens/committees.dart';
import 'package:smallorgsys/screens/event_details.dart';
import 'package:smallorgsys/screens/events.dart';
import 'package:smallorgsys/screens/head_home_page.dart';
import 'package:smallorgsys/screens/members_page.dart';
import 'package:smallorgsys/screens/news.dart';
import 'package:smallorgsys/screens/settings_page.dart';
import 'package:smallorgsys/screens/news_details.dart';
import 'package:smallorgsys/screens/speaker_page.dart';
import 'package:smallorgsys/screens/statistics.dart';
import 'package:smallorgsys/screens/user_home_page.dart';
import 'package:smallorgsys/screens/user_bottom_nav.dart';
import 'package:smallorgsys/screens/add_task.dart';
import 'package:smallorgsys/screens/settings_page.dart';
import 'screens/login.dart';
import 'package:smallorgsys/screens/evaluate_members.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEDxMIU',
      routes: {
        '/': (context) => NewsPage(),
        // '/newsDetails': (context) => NewsDetailsPage(index),
        '/events': (context) => EventsPage(),
        // '/eventDetails': (context) => EventDetailsPage(),
        '/login': (context) => LoginPage(),
        '/adminHomePage': (context) => AdminHomePage(),
        '/board': (context) => BoardPage(),
        '/aboutus': (context) => AboutUsPage(),
        '/speakerPage': (context) => SpeakerPage(),
        '/userHomePage': (context) => BottomNav(),
        '/userBottomNav': (context) => UserHomePage(),
        '/headHomePage': (context) => HeadHomePage(),
        '/membersPage': (context) => Members(),
        '/addTask': (context) => AddTask(),
        '/committeesPage': (context) => CommitteesPage(),
        '/addMember': (context) => AddMember(),
        '/statisticsPage': (context) => StatisticsPage(),
        '/evalMembers': (context) => EvalMembers(),
        '/settings': (context) => Settings(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.black,
        //canvasColor: Colors.redAccent[700],
        appBarTheme: AppBarTheme(
          color: Colors.black87,
        ),
      ),
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      // home: EventsPage(),
    );
  }
}
