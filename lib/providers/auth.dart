import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smallorgsys/models/http_exception.dart';
import 'package:smallorgsys/models/user.dart';

class Auth with ChangeNotifier {
  User _user;

  User get user {
    return _user;
  }

  bool get isAuth {
    return token != null;
  }

  String get userId {
    if (_user?.id != null) {
      return _user.id;
    }
    return null;
  }

  String get userName {
    return _user.name;
  }

  String get email {
    return _user.email;
  }

  bool get isAdmin {
    return _user.privilege == 'admin';
  }

  String get token {
    if (_user?.token != null) {
      return _user.token;
    }
    return null;
  }

  Future getTotalAtendedEvents({bool admin = false, String userId}) async {
    admin == false ? userId = this.userId : userId = userId;
    final res = await http.get(
        'https://tedxmiu-11c76-default-rtdb.firebaseio.com/usersAttendEvents/$userId.json');
    if (res.statusCode == 200) {
      var dbData = jsonDecode(res.body);
      return {
        'success': true,
        'totalAtendedEvents': dbData != null ? dbData.length : 0,
      };
    } else
      return {'success': false};
  }

  Future<void> _authenticate(String email, String password) async {
    final apiKey = "AIzaSyAiRfLTWytuOH8iEOqksPstuzsL2vKh0Lc";
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': false,
          },
        ),
      );
      log(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      // http.put(
      //   'https://tedxmiu-11c76-default-rtdb.firebaseio.com/users/${responseData['localId']}.json',
      //   body: json.encode(
      //     {
      //       'name': "Mark Refaat",
      //       'imagePath':
      //           "https://st.depositphotos.com/1269204/1219/i/600/depositphotos_12196477-stock-photo-smiling-men-isolated-on-the.jpg",
      //       'committee': "IT",
      //       'joinAt': "2017",
      //       'leftAt': "2020",
      //       'privilege': "member",
      //       'birthDate': '24-05-1999',
      //       'phone': '01278249244'
      //     },
      //   ),
      // );

      final response1 = await http.get(
          'https://tedxmiu-11c76-default-rtdb.firebaseio.com/users/${responseData['localId']}.json');
      final dbData = jsonDecode(response1.body) as Map<String, dynamic>;
      _user = User(
          name: dbData['name'],
          leftAt: dbData['leftAt'],
          joinAt: dbData['joinAt'],
          birthDate: dbData['birthDate'],
          committee: dbData['committee'],
          imagePath: dbData['imagePath'],
          privilege: dbData['privilege'],
          id: responseData['localId'],
          email: responseData['email'],
          token: responseData['idToken'],
          phone: dbData['phone'],
          rating: dbData['rating']);

      print("_user " + _user.name);

      if (_user.id == null) {
        throw HttpException('User ID is null');
      }
      print('Auth, User id is : ${_user.id}');
      //print('Auth, Token is : $_token');
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user_data', json.encode(_user.toJson()));
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<bool> autoLogin() async {
    if (isAuth) return true;
    // return Future.value(false);
    final prefs = await SharedPreferences.getInstance();
    print("prefs.containsKey('user_data') ${prefs.containsKey('user_data')}");
    if (!prefs.containsKey('user_data')) {
      return false;
    }
    final savedUserData =
        json.decode(prefs.getString('user_data')) as Map<String, dynamic>;

    print("//Auto Login $savedUserData");
    try {
      _user = User(
          id: savedUserData['id'],
          birthDate: savedUserData['birthDate'],
          committee: savedUserData['committee'],
          email: savedUserData['email'],
          imagePath: savedUserData['imagePath'],
          joinAt: savedUserData['joinAt'],
          leftAt: savedUserData['leftAt'],
          name: savedUserData['name'],
          phone: savedUserData['phone'],
          privilege: savedUserData['privilege'],
          token: savedUserData['token'],
          rating: savedUserData['rating']);
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
    }
    return true;
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user_data', null);
    // prefs.clear();
  }
}
