import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
            InkWell(
              child: ListTile(
                title: Text('Events'),
                leading: Icon(Icons.event),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
            Divider(),
            InkWell(
              child: ListTile(
                title: Text('Our Team'),
                leading: Icon(Icons.assignment_ind),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/board');
              },
            ),
            Divider(),
            InkWell(
              child: ListTile(
                title: Text('About us'),
                leading: Icon(Icons.info),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/aboutus');
              },
            ),
            Divider(),
            InkWell(
              child: ListTile(
                title: Text('Login'),
                leading: Icon(Icons.login),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/login');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: ListView(
        children: [
          eventCard(),
          eventCard(),
          eventCard(),
          eventCard(),
          eventCard(),
          eventCard(),
          eventCard(),
        ],
      ),
    );
  }

  Widget eventCard() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/eventDetails');
          },
          child: Card(
            child: Image.network(
              'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
              fit: BoxFit.fitWidth,
              height: 160,
            ),
          ),
        ),
      ),
    );
  }
}
