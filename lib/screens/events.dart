import 'package:flutter/material.dart';
import 'package:smallorgsys/screens/event_details.dart';

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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return eventCard(
              imagePath:
                  'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
              i: index);
        },
      ),
    );
  }

  Widget eventCard({@required imagePath, @required i}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventDetailsPage(i),
            ));
            // Navigator.of(context).pushNamed('/eventDetails');
          },
          child: Card(
            child: Hero(
              tag: i,
              child: Image.network(
                imagePath,
                fit: BoxFit.fitWidth,
                height: 160,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
