import 'package:flutter/material.dart';

class NewsDetailsPage extends StatelessWidget {
  int index;
  NewsDetailsPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Supernova News'),
      ),
      body: new ListView(
        children: <Widget>[
          Hero(
            tag: index,
            child: new Image.network(
              'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
              repeat: ImageRepeat.noRepeat,
              fit: BoxFit.fitWidth,
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
              'descriptiondescriptiondescriptiondescriptiondescription'
              'descriptiondescriptiondescriptiondescriptiondescription'
              'descriptiondescriptiondescriptiondescriptiondescription'
              'descriptiondescriptiondescriptiondescriptiondescription'
              'descriptiondescriptiondescriptiondescriptiondescription',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
