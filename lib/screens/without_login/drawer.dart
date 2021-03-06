import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smallorgsys/providers/auth.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  // var authProvider;
  @override
  Widget build(BuildContext context) {
    // authProvider = Provider.of<Auth>(context);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: ListView(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(10.0)),
                CircleAvatar(
                  child: Image.asset(
                    'images/drawer/tedxMiuHome.jpg',
                  ),
                  maxRadius: 35.0,
                  minRadius: 25.0,
                ),
                Padding(padding: const EdgeInsets.all(10.0)),
                Text(
                  'TEDx MIU',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          drawerTile(title: 'Home', icon: Icons.home, route: '/'),
          Divider(),
          Consumer<Auth>(
            builder: (ctx, auth, _) => FutureBuilder(
              future: auth.autoLogin(),
              // ignore: missing_return
              builder: (ctx, autResSnapshot) {
                if (autResSnapshot.data == true) {
                  if (auth.user.privilege == "member") {
                    return drawerTile(
                        title: 'Profile',
                        icon: Icons.person,
                        route: '/userHomePage');
                  } else if (auth.user.privilege == "head") {
                    return drawerTile(
                        title: 'Management',
                        icon: Icons.handyman,
                        route: '/headHomePage');
                  } else if (auth.user.privilege == "admin") {
                    return drawerTile(
                        title: 'Management',
                        icon: Icons.handyman,
                        route: '/adminHomePage');
                  }
                } else if (autResSnapshot.connectionState ==
                    ConnectionState.waiting)
                  return CircularProgressIndicator();
                else
                  return drawerTile(
                      title: 'Login', icon: Icons.login, route: '/login');
              },
            ),
          ),
          Divider(),
          drawerTile(title: 'News', icon: Icons.event, route: '/news'),
          Divider(),
          drawerTile(title: 'Events', icon: Icons.event, route: '/events'),
          Divider(),
          drawerTile(
              title: 'Our Team', icon: Icons.assignment_ind, route: '/board'),
          Divider(),
          drawerTile(title: 'About us', icon: Icons.info, route: '/aboutus'),
          Divider(),
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            // ignore: missing_return
            builder: (ctx, AsyncSnapshot<SharedPreferences> autResSnapshot) {
              if (autResSnapshot.connectionState == ConnectionState.done &&
                  autResSnapshot.hasData) {
                return CheckboxListTile(
                    title: Text("Receive notification"),
                    value: autResSnapshot.data.getBool('subNotifications'),
                    onChanged: (newValue) {
                      setState(() {
                        autResSnapshot.data
                            .setBool('subNotifications', newValue);
                        OneSignal.shared.setSubscription(newValue);
                      });
                    },
                    controlAffinity: ListTileControlAffinity.platform);
              } else if (autResSnapshot.connectionState ==
                  ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }

  Widget drawerTile({@required title, @required icon, @required route}) {
    return InkWell(
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}
