// import 'package:flutter/widgets.dart';
// import 'package:smallorgsys/models/task.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class TasksController with ChangeNotifier {
//   List<Task> _tasksList = [];

//   void addTask(Task task) {
//     http.post(
//       'https://tedxmiu-11c76-default-rtdb.firebaseio.com/tasks.json',
//       body: json.encode(
//         {
//           'title' : task.title,
//           'assignedto': task.assignedto,
//           'description': task.description,
//           'assignedby': task.assignedby,
//           'status' : task.status
//         },
//       ),
//     );
//     notifyListeners();
//   }

//   List<Task> get tasks {
//     return [..._tasksList];
//   }

//     Task findByTitle(String title) {
//     return _tasksList.firstWhere((tasks) => tasks.title == title);
//   }

//   Future<void> fetchAndSetTasks() async {
//     try {
//       final response = await http
//           .get('https://tedxmiu-11c76-default-rtdb.firebaseio.com/tasks.json');
//       final dbData = jsonDecode(response.body) as Map<String, dynamic>;
//       final List<Task> dbTask = [];
//       dbData.forEach((key, data) {
//         dbTask.add(
//           Task(

//           title: data['title'],
//           assignedto: data['assignedto'],
//           description: data['description'],
//           assignedby : data['assignedby'],
//           status : data['status'],
//           ),
//         );
//       });
//       print(dbTask[0].title);
//       _tasksList = dbTask;
//       notifyListeners();
//     } on Exception catch (e) {
//       print(e.toString());
//       throw (e);
//     }
//   }
// }
