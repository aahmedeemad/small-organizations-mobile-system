import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/providers/event_provider.dart';
import 'package:smallorgsys/screens/event_details.dart';
import 'package:smallorgsys/models/event.dart';
import 'package:http/http.dart' as http;

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  EventsController providerEventsController;
  @override
  void initState() {
    Provider.of<EventsController>(context, listen: false)
        .fetchAndSetEvents()
        .then((_) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> _refresh(context) async {
    await providerEventsController.fetchAndSetEvents();
  }

  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    providerEventsController = Provider.of<EventsController>(context);

    for (final Event event in providerEventsController.events) {
      final marker = Marker(
        markerId: MarkerId(event.title),
        position: LatLng(event.latitude, event.longitude),
        infoWindow: InfoWindow(
          title: event.title,
          snippet: event.description,
        ),
      );
      _markers[event.id] = marker;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: FutureBuilder(
          future: http.get(
              'https://tedxmiu-11c76-default-rtdb.firebaseio.com/events.json'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('An error ocurred while retriving data,'),
                      Text('Please check your network connection!'),
                      RaisedButton(
                        child: Text("Retry"),
                        onPressed: () => _refresh(context),
                      )
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => _refresh(context),
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            providerEventsController.events[0].latitude,
                            providerEventsController.events[0].longitude,
                          ),
                          zoom: 11.0,
                        ),
                        markers: _markers.values.toSet(),
                      ),
                    ),
                    for (final Event event in providerEventsController.events)
                      eventCard(imagePath: event.imagePath, id: event.id),
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget eventCard({@required imagePath, @required id}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EventDetailsPage(id),
            ));
            // Navigator.of(context).pushNamed('/eventDetails');
          },
          child: Card(
            child: Hero(
              tag: id,
              child: CachedNetworkImage(
                imageUrl: imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                height: 160,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
