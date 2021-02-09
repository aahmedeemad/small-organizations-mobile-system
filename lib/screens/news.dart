import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/controllers/news_controller.dart';
import 'package:smallorgsys/screens/drawer.dart';
import 'package:smallorgsys/screens/news_details.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // var n = News(title: "1", imagePath: ".com", description: "asd")..news;
  var _isLoading = true;
  var providerNewsController;
  @override
  void initState() {
    Provider.of<NewsController>(context, listen: false)
        .fetchAndSetNews()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  Future<void> _refresh(context) async {
    await providerNewsController.fetchAndSetNews();
  }

  @override
  Widget build(BuildContext context) {
    providerNewsController = Provider.of<NewsController>(context);
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text('News'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _refresh(context),
              child: ListView.builder(
                itemCount: providerNewsController.news.length,
                itemBuilder: (context, index) {
                  return eventCard(
                      imagePath: providerNewsController.news[index].imagePath,
                      id: providerNewsController.news[index].id);
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
              builder: (context) => NewsDetailsPage(id),
            ));
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
