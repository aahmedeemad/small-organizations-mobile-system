import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/providers/speakers_provider.dart';

class SpeakerPage extends StatefulWidget {
  final speakerID;
  SpeakerPage({this.speakerID}) {
    print(speakerID);
  }
  @override
  _SpeakerPageState createState() => _SpeakerPageState();
}

class _SpeakerPageState extends State<SpeakerPage> {
  var _isLoading = true;
  var providerSpeakersController;
  @override
  void initState() {
    Provider.of<SpeakersController>(context, listen: false)
        .fetchSpeaker(widget.speakerID)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> _refresh(context) async {
    setState(() {
      Provider.of<SpeakersController>(context, listen: false)
          .fetchSpeaker(widget.speakerID);
    });
  }

  @override
  Widget build(BuildContext context) {
    providerSpeakersController =
        Provider.of<SpeakersController>(context, listen: false);
    return new Scaffold(
      appBar: AppBar(
        title: Text('Speaker Profile'),
      ),
      body: new Stack(
        children: <Widget>[
          Container(color: Colors.black87.withOpacity(0.8)),
          ClipPath(
            child: Container(color: Colors.redAccent[700].withOpacity(0.8)),
            clipper: getClipper(),
          ),
          FutureBuilder(
              future: providerSpeakersController.fetchSpeaker(widget.speakerID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (!snapshot.hasError) {
                    return Positioned(
                      width: MediaQuery.of(context).size.width,
                      top: MediaQuery.of(context).size.height / 15,
                      child: Column(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl:
                                providerSpeakersController.speaker.imagePath,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.grey[100],
                              child: Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(75.0)),
                                ),
                              ),
                            ),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fitWidth,
                            repeat: ImageRepeat.noRepeat,
                          ),
                          SizedBox(height: 40.0),
                          Text(
                            providerSpeakersController.speaker.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            providerSpeakersController.speaker.slogan,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(height: 35.0),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              providerSpeakersController
                                  .speaker.fullDescription,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else
                    return errorWidget(context);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }

  Widget errorWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('An error occurred while retrieving data,'),
          Text('Please check your network connection!'),
          RaisedButton(
            child: Text("Retry"),
            onPressed: () => _refresh(context),
          )
        ],
      ),
    );
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
