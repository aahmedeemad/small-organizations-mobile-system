import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/providers/event_provider.dart';
import 'package:smallorgsys/models/event.dart';
import 'package:smallorgsys/screens/without_login/drawer.dart';
import 'package:smallorgsys/screens/without_login/event_details.dart';
import 'package:smallorgsys/widgets/network_error_widget.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  EventsController providerEventsController;
  @override
  void initState() {
    providerEventsController =
        Provider.of<EventsController>(context, listen: false);
    super.initState();
  }

  Future<void> _refresh(context) async {
    setState(() {
      providerEventsController.fetchAndSetEvents();
    });
  }

  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    // providerEventsController = Provider.of<EventsController>(context);

    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: FutureBuilder(
          future: providerEventsController.fetchAndSetEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data == true) {
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
                return RefreshIndicator(
                  onRefresh: () => _refresh(context),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              30.09,
                              31.29,
                            ),
                            zoom: 10.0,
                          ),
                          markers: _markers.values.toSet(),
                        ),
                      ),
                      for (final Event event in providerEventsController.events)
                        eventCard(imagePath: event.imagePath, id: event.id),
                    ],
                  ),
                );
              } else
                return NetworkErrorWidget(retryButton: () => _refresh(context));
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
