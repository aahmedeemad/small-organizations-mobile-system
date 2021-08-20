import 'package:flutter/material.dart';
import 'package:smallorgsys/screens/without_login/drawer.dart';
import 'package:smallorgsys/screens/without_login/event_details.dart';
import 'package:smallorgsys/screens/without_login/news_details.dart';
import 'package:smallorgsys/widgets/network_error_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smallorgsys/providers/event_provider.dart';
import 'package:smallorgsys/providers/news_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  EventsController providerEventsController;
  NewsController providerNewsController;

  @override
  void initState() {
    providerEventsController =
        Provider.of<EventsController>(context, listen: false);
    providerNewsController =
        Provider.of<NewsController>(context, listen: false);
    super.initState();
  }

  Future<void> _refresh(context) async {
    setState(() {
      providerEventsController.fetchAndSetEvents();
      providerNewsController.fetchAndSetNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: FutureBuilder(
          future: providerEventsController.fetchAndSetEvents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data == true) {
                return ListView(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Latest News",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.grey[600]),
                      ),
                    ),
                    FutureBuilder(
                      future: providerNewsController.fetchAndSetNews(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData && snapshot.data == true) {
                            return CarouselSlider(
                              items: [
                                for (var i = 0; i < 3; i++)
                                  GestureDetector(
                                      child:
                                          //1st Image of Slider
                                          Container(
                                        margin: EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "${providerNewsController.news[i].imagePath}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => NewsDetailsPage(
                                              "${providerNewsController.news[i].id}"),
                                        ));
                                      }),
                              ],
                              //Slider Container properties
                              options: CarouselOptions(
                                height: 180.0,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                            );
                          } else
                            return null;
                        } else
                          return Center(child: CircularProgressIndicator());
                      },
                    ),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Latest Event",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.grey[600]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: InkWell(
                          onTap: () {
                            var eventid = 0;
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EventDetailsPage(
                                  '${providerEventsController.events[eventid].id}'),
                            ));
                          },
                          child: Card(
                            child: Hero(
                              tag: 0,
                              child: CachedNetworkImage(
                                imageUrl: providerEventsController
                                    .events[0].imagePath,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                height: 200,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Reach us through",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.grey[600]),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
                    Center(
                      child: Row(
                        children: <Widget>[
                          socialMediaProfile(
                            image: 'images/home/fb.png',
                            url: "https://www.facebook.com/TEDxMIU",
                            context: context,
                          ),
                          socialMediaProfile(
                            image: 'images/home/ig.png',
                            url: "https://www.instagram.com/tedxmiu/",
                            context: context,
                          ),
                          socialMediaProfile(
                            image: 'images/home/tw.png',
                            url: 'https://twitter.com/tedxmiu',
                            context: context,
                          ),
                          socialMediaProfile(
                            image: 'images/home/in.png',
                            url: 'https://eg.linkedin.com/company/tedxmiu',
                            context: context,
                          ),
                        ],
                      ),
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

  Widget socialMediaProfile({
    @required image,
    @required url,
    @required context,
  }) {
    return Expanded(
      child: new FlatButton(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.asset(image),
        color: Colors.blueAccent[600],
        onPressed: () => _launch(url: url, context: context),
      ),
    );
  }

  void _launch({@required url, @required context}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
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
