import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:smallorgsys/models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:smallorgsys/providers/auth.dart';

class TasksController with ChangeNotifier {
  List<Task> _tasksList = [];
  List<Task> _singleUserTasks = [];
  String authToken;
  String userId;

  TasksController(this.authToken, this.userId, this._singleUserTasks);
  // void addTask(Task task) {
  //   http.post(
  //     'https://tedxmiu-11c76-default-rtdb.firebaseio.com/tasks.json',
  //     body: json.encode(
  //       {
  //         'title' : task.title,
  //         'assignedto': task.assignedto,
  //         'description': task.description,
  //         'assignedby': task.assignedby,
  //         'status' : task.status
  //       },
  //     ),
  //   );
  //   notifyListeners();
  // }

  List<Task> get tasks {
    return [..._tasksList];
  }

  List<Task> get usertasks {
    return [..._singleUserTasks];
  }

  Task findByTitle(String title) {
    return _tasksList.firstWhere((tasks) => tasks.title == title);
  }

  Future getTask({bool admin = false, String requestedId = ''}) async {
    // final res = await http.post(
    //     'https://tedxmiu-11c76-default-rtdb.firebaseio.com/usersTasks/$userId.json',
    //     body: jsonEncode(
    //         {'title': 'task1', 'description': 'desc1', 'status': true}));
    // if (res.statusCode == 200) {
    //   var dbData = jsonDecode(res.body);

    //   return {
    //     'success': true,
    //     'tasks': dbData,
    //   };
    // } else
    //   return {'success': false};
    String userId = '';
    if (admin == true && requestedId != '') {
      userId = requestedId;
    } else if (admin == false) {
      userId = this.userId;
    }

    final res = await http.get(
        'https://tedxmiu-11c76-default-rtdb.firebaseio.com/usersTasks/$userId.json');
    if (res.statusCode == 200) {
      Map<String, dynamic> dbData = jsonDecode(res.body);
      final List<Task> tasks = [];

      dbData.forEach((k, v) {
        tasks.add(
          Task(
            title: v['title'],
            description: v['description'],
            status: v['status'],
            id: k,
            // userId: v['userId']
          ),
        );
      });
      _singleUserTasks = tasks;
      return true;
    } else
      print(res.statusCode);
    return false;
  }

  Future changeTaskStatus(
      {@required Task task, @required dynamic userId}) async {
    final res = await http.put(
      'https://tedxmiu-11c76-default-rtdb.firebaseio.com/usersTasks/${userId}/${task.id}.json',
      body: json.encode(
        {
          'title': task.title,
          'description': task.description,
          'status': !task.status,
        },
      ),
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  void receiveToken(Auth auth, List<Task> items) {
    this.authToken = auth.token;
    this.userId = auth.userId;
    this._singleUserTasks = items;
  }

  // Future<void> fetchAndSetTasks() async {
  //   try {
  //     final response = await http
  //         .get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/tasks.json');
  //     final dbData = jsonDecode(response.body) as Map<String, dynamic>;
  //     final List<Task> dbTask = [];
  //     dbData.forEach((key, data) {
  //       // dbTask.add(
  //       //   Task(
  //       //     title: data['title'],
  //       //     assignedto: data['assignedto'],
  //       //     description: data['description'],
  //       //     assignedby: data['assignedby'],
  //       //     status: data['status'],
  //       //   ),
  //       // );
  //     });

  //     _tasksList = dbTask;
  //     notifyListeners();
  //   } on Exception catch (e) {
  //     print(e.toString());
  //     throw (e);
  //   }
  // }
}
