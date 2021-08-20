import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/models/event.dart';
import 'package:smallorgsys/providers/event_provider.dart';
import 'package:smallorgsys/providers/speakers_provider.dart';
import 'package:smallorgsys/screens/without_login/speaker_page.dart';
import 'package:smallorgsys/widgets/network_error_widget.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

// ignore: must_be_immutable
class EventDetailsPage extends StatefulWidget {
  final String id;
  Event event;
  EventDetailsPage(this.id);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  var providerSpeakersController;

  Future<void> _refresh(context) async {
    setState(() {});
  }

  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    providerSpeakersController =
        Provider.of<SpeakersController>(context, listen: false);
    widget.event = Provider.of<EventsController>(context, listen: false)
        .findById(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: FutureBuilder(
          future: providerSpeakersController.fetchAndSetSpeakers(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasError) {
                return ListView(
                  children: <Widget>[
                    Hero(
                      tag: widget.id,
                      child: CachedNetworkImage(
                        imageUrl: widget.event.imagePath,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fitWidth,
                        repeat: ImageRepeat.noRepeat,
                      ),
                    ),
                    SizedBox(height: 10.0, width: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.date_range),
                                  Text(
                                    widget.event.date,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _launchUrl(widget.event.locationUrl);
                                      },
                                      child: Text(
                                        widget.event.locationName,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25, width: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            widget.event.description,
                            maxLines: descTextShowFlag ? 1000 : 2,
                            textAlign: TextAlign.start,
                            //textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w300),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                descTextShowFlag = !descTextShowFlag;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                descTextShowFlag
                                    ? Text(
                                        "...Show Less",
                                        style: TextStyle(color: Colors.blue),
                                      )
                                    : Text("Show More...",
                                        style: TextStyle(color: Colors.blue))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 7.0, top: 20.0, bottom: 7.0, right: 7.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.people),
                          Text(
                            ' Speakers',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: providerSpeakersController.speakers.length,
                      itemBuilder: (context, index) {
                        return speaker(
                          id: providerSpeakersController.speakers[index].id,
                          imagePath: providerSpeakersController
                              .speakers[index].imagePath,
                          name: providerSpeakersController.speakers[index].name,
                          bio: providerSpeakersController.speakers[index].bio,
                          from: providerSpeakersController.speakers[index].from,
                          to: providerSpeakersController.speakers[index].to,
                        );
                      },
                    ),
                  ],
                );
              } else
                return NetworkErrorWidget(retryButton: () => _refresh(context));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget speaker(
      {@required id,
      @required imagePath,
      @required name,
      @required bio,
      @required from,
      @required to}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SpeakerPage(speakerID: id),
        ));
        // Navigator.of(context).pushNamed('/speakerPage');
      },
      child: new Card(
        child: new ListTile(
          leading: new CircleAvatar(
            backgroundColor: Colors.black87,
            minRadius: 10.0,
            maxRadius: 20.0,
            child: new ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: new Image.network(
                imagePath,
              ),
            ),
          ),
          title: new Text(name),
          subtitle: new Text(bio),
          trailing: new Text('$from - $to'),
        ),
      ),
    );
  }

  void _launchUrl(url) async {
    if (await launcher.canLaunch(url))
      await launcher.launch(url);
    else {
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Alert!"),
        content: Text("Can't open this website."),
        actions: [
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
