import 'package:flutter/material.dart';
import 'package:smallorgsys/screens/drawer.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text('News'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return eventCard();
        },
      ),
    );
  }

  Widget eventCard() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed('/newsDetails');
          },
          child: Card(
            child: Image.network(
              'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
              fit: BoxFit.fitWidth,
              height: 160,
            ),
          ),
        ),
      ),
    );
  }
}
