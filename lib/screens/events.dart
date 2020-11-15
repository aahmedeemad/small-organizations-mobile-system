import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
