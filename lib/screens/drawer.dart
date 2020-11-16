import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
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
          drawerTile(title: 'Login', icon: Icons.login, route: '/login'),
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
