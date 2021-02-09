import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/controllers/event_controller.dart';
import 'package:smallorgsys/screens/event_details.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  var _isLoading = true;
  var providerEventsController;
  @override
  void initState() {
    Provider.of<EventsController>(context, listen: false)
        .fetchAndSetEvents()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> _refresh(context) async {
    await providerEventsController.fetchAndSetEvents();
  }

  @override
  Widget build(BuildContext context) {
    providerEventsController = Provider.of<EventsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView.builder(
                itemCount: providerEventsController.events.length,
                itemBuilder: (context, index) {
                  return eventCard(
                      imagePath:
                          providerEventsController.events[index].imagePath,
                      id: providerEventsController.events[index].id);
                },
              ),
            ),
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
