import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/user.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:smallorgsys/providers/users_provider.dart';
import 'package:smallorgsys/screens/with_login/head/head_user_tasks.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  UsersController usersController;
  Future<List<User>> users;

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usersController = Provider.of<UsersController>(context, listen: false);
    Provider.of<UsersController>(context, listen: false)
        .fetchAndSetUsers(
            filter: Provider.of<Auth>(context, listen: false).user.committee)
        .then((_) {
      setState(() {
        users = Future.value(usersController.users
            .where((user) =>
                user.committee ==
                    Provider.of<Auth>(context, listen: false).user.committee &&
                user.id != Provider.of<Auth>(context, listen: false).user.id)
            .toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new task')),
      body: Builder(
        builder: (context) => Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: FutureBuilder(
              future: users,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HeadUserTasks(
                                    id: snapshot.data[index].id,
                                    committee: snapshot.data[index].committee),
                              ));
                            },
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data[index].imagePath),
                            ),
                            title: Text(snapshot.data[index].name),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            // child: ListView(
            //   children: [
            //     TextFormField(
            //       validator: (value) {
            //         if (value.isEmpty) {
            //           return 'Please enter some text';
            //         }
            //         return null;
            //       },
            //       decoration: InputDecoration(
            //         labelText: "Task name",
            //       ),
            //     ),
            //     TextFormField(
            //       validator: (value) {
            //         if (value.isEmpty) {
            //           return 'Please enter some text';
            //         }
            //         return null;
            //       },
            //       decoration: InputDecoration(
            //         labelText: "Task description",
            //       ),
            //     ),
            //     new DropdownButton<String>(
            //       items: dropdownValues.map((String value) {
            //         return new DropdownMenuItem<String>(
            //           value: value,
            //           child: new Text(value),
            //         );
            //       }).toList(),
            //       value: dropdownValue,
            //       onChanged: (_) {
            //         setState(() {
            //           dropdownValue = _;
            //         });
            //       },
            //     ),
            //     MaterialButton(
            //       onPressed: () {
            //         if (_formkey.currentState.validate()) {
            //           Scaffold.of(context).showSnackBar(
            //               SnackBar(content: Text('Processing Data')));
            //         }
            //       },
            //       child: Text("Add"),
            //       color: Colors.red,
            //       textColor: Colors.white,
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
