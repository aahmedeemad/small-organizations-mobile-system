import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/news.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsController with ChangeNotifier {
  List<News> _newsList = [];

  /*void addNews(News news) {
    http.post(
      'https://tedxmiu-11c76-default-rtdb.firebaseio.com/news.json',
      body: json.encode(
        {
          'title': news.title,
          'imagePath': news.imagePath,
          'description': news.description
        },
      ),
    );
    notifyListeners();
  }*/

  List<News> get news {
    return [..._newsList];
  }

  News findById(String id) {
    return _newsList.firstWhere((news) => news.id == id);
  }

  Future<bool> fetchAndSetNews() async {
    try {
      //final response = await http.get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/news.json');
      final response = await http.get('http://tedxmiu.com/newsapi.php');
      if (response.statusCode == 200 && response.body != null) {
        final dbData = jsonDecode(response.body);
        final List<News> dbNews = [];
        dbData.forEach((data) {
          dbNews.add(
            News(
              id: data['id'],
              title: data['title'],
              imagePath: 'http://tedxmiu.com/' + data['imagePath'],
              description: data['description'],
            ),
          );
        });
        _newsList = dbNews;
        notifyListeners();
        return true;
      }
      return false;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }
}
