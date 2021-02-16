import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsersController with ChangeNotifier {
  List<User> _usersList = [];


  void addUser(User user) {
    http.post(
      'https://tedxmiu-11c76-default-rtdb.firebaseio.com/users.json',
      body: json.encode(
        {
          'id' : user.id,
          'name': user.name,
          'imagepath': user.imagepath,
          'qrCode': user.qrCode,
          'task' : user.task
        },
      ),
    );
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

  Future<void> fetchAndSetUsers() async {
    try {
      final response = await http
          .get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/users.json');
      final dbData = jsonDecode(response.body) as Map<String, dynamic>;
      final List<User> dbUser = [];
      dbData.forEach((key, data) {
        dbUser.add(
          User(
            id : key,
          name: data['name'],
          imagepath: data['imagepath'],
          qrCode: data['qrCode'],
          task : data['task'],
            
          ),
        );
      });
      print(dbUser[0].name);
      _usersList = dbUser;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}