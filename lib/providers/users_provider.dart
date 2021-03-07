import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersController with ChangeNotifier {
  List<User> _usersList = [];

  void addUser(User user) {
    // http.post(
    //   'https://tedxmiu-11c76-default-rtdb.firebaseio.com/users.json',
    //   body: json.encode(
    //     {
    //       'id': user.id,
    //       'name': user.name,
    //       'imagepath': user.imagepath,
    //       'qrCode': user.qrCode,
    //       'task': user.task
    //     },
    //   ),
    // );
    notifyListeners();
  }

  List<User> get users {
    return [..._usersList];
  }

  User findByName(String name) {
    return _usersList.firstWhere((users) => users.name == name);
  }

  User findById(String id) {
    return _usersList.firstWhere((users) => users.id == id);
  }

  Future<void> fetchAndSetUsers({String filter = ''}) async {
    String filterParameters = '';
    try {
      filterParameters =
          filter != '' ? 'orderBy="committee"&equalTo="$filter"' : '';
      print(filterParameters);
      final res = await http.get(
          'https://tedxmiu-11c76-default-rtdb.firebaseio.com/users.json?$filterParameters');
      print(res);
      if (res.statusCode == 200) {
        final dbData = jsonDecode(res.body) as Map<String, dynamic>;
        final List<User> dbUser = [];
        dbData.forEach((key, data) {
          dbUser.add(User(
              id: key,
              birthDate: data['birthDate'],
              committee: data['committee'],
              email: data['email'],
              imagePath: data['imagePath'],
              joinAt: data['joinAt'],
              leftAt: data['leftAt'],
              name: data['name'],
              phone: data['phone'],
              privilege: data['privilege'],
              token: data['token'],
              rating: data['rating']));
        });
        _usersList = dbUser;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  Future<bool> updateUserRating({int rating, String userId}) async {
    print(userId);
    try {
      final res = await http.patch(
        'https://tedxmiu-11c76-default-rtdb.firebaseio.com/users/$userId.json',
        body: json.encode(
          {
            'rating': rating,
          },
        ),
      );
      if (res.statusCode == 200) {
        var index = _usersList.indexWhere((user) => user.id == userId);
        _usersList[index].rating = rating;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
