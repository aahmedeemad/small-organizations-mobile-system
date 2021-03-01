import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/news.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class NewsController with ChangeNotifier {
  List<News> _newsList = [];
  String status = '';

  void addNews(News news) {
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
  }

  List<News> get news {
    return [..._newsList];
  }

  News findById(String id) {
    return _newsList.firstWhere((news) => news.id == id);
  }

  Future<void> fetchAndSetNews() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        status = 'provider connected';
        //print(status);
        try {
          final response = await http.get(
              'https://tedxmiu-11c76-default-rtdb.firebaseio.com/news.json');
          final dbData = jsonDecode(response.body) as Map<String, dynamic>;
          final List<News> dbNews = [];
          dbData.forEach((key, data) {
            dbNews.add(
              News(
                id: key,
                title: data['title'],
                imagePath: data['imagePath'],
                description: data['description'],
              ),
            );
          });
          print(dbNews[0].imagePath);
          _newsList = dbNews;
          notifyListeners();
        } on Exception catch (e) {
          print(e.toString());
          throw (e);
        }
      }
    } on SocketException catch (_) {
      status = 'provider not connected';
      //print(status);
      return status;
    }
  }
}
