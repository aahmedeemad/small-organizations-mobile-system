import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:smallorgsys/screens/login.dart';
import 'package:smallorgsys/screens/user_bottom_nav.dart';

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
                    'images/tedxMiuHome.jpg',
                  ),
                  maxRadius: 35.0,
                  minRadius: 25.0,
                ),
                Padding(padding: const EdgeInsets.all(10.0)),
                Text(
                  'TEDX MIU',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          drawerTile(title: 'News', icon: Icons.event, route: '/'),
          Divider(),
          drawerTile(title: 'Events', icon: Icons.event, route: '/events'),
          Divider(),
          drawerTile(
              title: 'Our Team', icon: Icons.assignment_ind, route: '/board'),
          Divider(),
          drawerTile(title: 'About us', icon: Icons.info, route: '/aboutus'),
          Divider(),
          InkWell(
            child: Consumer<Auth>(
              builder: (ctx, auth, _) => ListTile(
                title: Text(auth.isAuth ? "Profile" : "Login"),
                leading: Icon(auth.isAuth ? Icons.home : Icons.login),
                onTap: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return auth.isAuth
                        ? BottomNav()
                        : FutureBuilder(
                            future: auth.autoLogin(),
                            builder: (ctx, autResSnapshot) {
                              if (autResSnapshot.data == true)
                                return BottomNav();
                              else if (autResSnapshot.connectionState ==
                                  ConnectionState.waiting)
                                return CircularProgressIndicator();
                              else
                                return LoginPage();
                            });
                  }));
                  // auth.isAuth
                  //     ? Navigator.of(context).pushNamed('/userHomePage')
                  //     : Navigator.of(context).pushNamed('/login');
                },
              ),
            ),
          ),

          // drawerTile(title: 'Login', icon: Icons.login, route: '/login'),
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
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}
