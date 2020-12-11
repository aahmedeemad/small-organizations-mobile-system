import 'package:flutter/material.dart';
import 'package:smallorgsys/screens/drawer.dart';
import 'package:smallorgsys/screens/news_details.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
/*    return Scaffold(
      drawer: DrawerPage(),
      appBar: AppBar(
        title: Text('News'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return eventCard(
              imagePath:
                  'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
              i: index);
        },
      ),
    );*/
    return Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          title: Text('News'),
        ),
        body: Stack(
          children: <Widget>[
            Container(color: Colors.black87.withOpacity(0.8)),
            ClipPath(
              child: Container(color: Colors.redAccent[700].withOpacity(0.8)),
              clipper: getClipper(),
            ),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return eventCard(
                    imagePath:
                        'https://pi.tedcdn.com/r/www.filepicker.io/api/file/vCGCek3NTu7SNHe4tcZv?quality=90&w=260',
                    i: index);
              },
            ),
          ],
        ));
  }

  Widget eventCard({@required imagePath, @required i}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewsDetailsPage(i),
            ));
          },
          child: Card(
            child: Hero(
              tag: i,
              child: Image.network(
                imagePath,
                fit: BoxFit.fitWidth,
                height: 160,
              ),
            ),
          ),
        ),
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
