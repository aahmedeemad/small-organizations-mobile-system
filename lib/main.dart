import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:smallorgsys/providers/board_provider.dart';
import 'package:smallorgsys/providers/event_provider.dart';
import 'package:smallorgsys/providers/news_provider.dart';
import 'package:smallorgsys/providers/speakers_provider.dart';
import 'package:smallorgsys/providers/tasks_provider.dart';
import 'package:smallorgsys/providers/users_provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:smallorgsys/screens/with_login/admin/admin_home_page.dart';
import 'package:smallorgsys/screens/with_login/admin/committees.dart';
import 'package:smallorgsys/screens/with_login/admin/evaluate_members.dart';
import 'package:smallorgsys/screens/with_login/admin/members_page.dart';
import 'package:smallorgsys/screens/with_login/admin/statistics.dart';
import 'package:smallorgsys/screens/with_login/head/add_member.dart';
import 'package:smallorgsys/screens/with_login/head/add_task.dart';
import 'package:smallorgsys/screens/with_login/head/head_home_page.dart';
import 'package:smallorgsys/screens/with_login/member/settings_page.dart';
import 'package:smallorgsys/screens/with_login/member/user_bottom_nav.dart';
import 'package:smallorgsys/screens/with_login/member/user_home_page.dart';
import 'package:smallorgsys/screens/with_login/scan_qr.dart';
import 'package:smallorgsys/screens/without_login/about_us.dart';
import 'package:smallorgsys/screens/without_login/board.dart';
import 'package:smallorgsys/screens/without_login/events.dart';
import 'package:smallorgsys/screens/without_login/home.dart';
import 'package:smallorgsys/screens/without_login/login.dart';
import 'package:smallorgsys/screens/without_login/news.dart';
import 'package:smallorgsys/screens/without_login/speaker_page.dart';

void main() async {
  runApp(
    provider.ChangeNotifierProvider(
      create: (context) => Auth(),
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      if (result.notification.payload.additionalData != null) {
        if (result.notification.payload.additionalData['page'] == "news") {
          await navigatorKey.currentState.pushNamed('/news');
        } else if (result.notification.payload.additionalData['page'] ==
            "events") {
          await navigatorKey.currentState.pushNamed('/events');
        }
      }
    });

    await OneSignal.shared.init("078531c6-98d6-43fe-bbaa-79c2e39650be");

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool('subNotifications') == null) {
      sharedPreferences.setBool('subNotifications', true);
      OneSignal.shared.setSubscription(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        ChangeNotifierProxyProvider<Auth, TasksController>(
          create: (_) => TasksController(
              Provider.of<Auth>(context, listen: false).token,
              Provider.of<Auth>(context, listen: false).userId, []),
          update: (ctx, auth, tasks) =>
              tasks..receiveToken(auth, tasks.usertasks),
        ),
        provider.ChangeNotifierProvider.value(
          value: NewsController(),
        ),
        provider.ChangeNotifierProvider.value(
          value: EventsController(),
        ),
        provider.ChangeNotifierProvider.value(
          value: SpeakersController(),
        ),
        provider.ChangeNotifierProvider.value(
          value: BoardController(),
        ),
        provider.ChangeNotifierProvider.value(
          value: UsersController(),
        ),
        // provider.ChangeNotifierProvider.value(
        //   value: TasksController(),
        // ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Tedx MIU',
        routes: {
          '/': (context) => HomePage(),
          '/news': (context) => NewsPage(),
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
          '/scanQr': (context) => ScanQrPage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.black,
          appBarTheme: AppBarTheme(
            color: Colors.black87,
          ),
        ),
        // theme: ThemeData.light(),
        // darkTheme: ThemeData.dark(),
        // home: EventsPage(),
      ),
    );
  }
}
