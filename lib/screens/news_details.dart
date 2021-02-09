import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smallorgsys/controllers/news_controller.dart';
import 'package:smallorgsys/models/news.dart';

class NewsDetailsPage extends StatelessWidget {
  final String id;
  News news;
  NewsDetailsPage(this.id);
  @override
  Widget build(BuildContext context) {
    this.news =
        Provider.of<NewsController>(context, listen: false).findById(this.id);
    return Scaffold(
      appBar: new AppBar(
        title: new Text(this.news.title),
      ),
      body: new ListView(
        children: <Widget>[
          Hero(
            tag: id,
            child: CachedNetworkImage(
              imageUrl: this.news.imagePath,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
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
          new Padding(padding: const EdgeInsets.all(5.0)),
          new Padding(
            padding: const EdgeInsets.only(
                left: 7.0, top: 15.0, bottom: 7.0, right: 7.0),
          ),
          new Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: new Text(
              this.news.description,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
