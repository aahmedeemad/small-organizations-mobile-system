import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/task.dart';
import 'package:smallorgsys/providers/tasks_provider.dart';

class HeadUserTasks extends StatefulWidget {
  final String id;
  final String committee;

  const HeadUserTasks({@required this.id, @required this.committee});
  @override
  _HeadUserTasksState createState() => _HeadUserTasksState();
}

class _HeadUserTasksState extends State<HeadUserTasks> {
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descEditingController = TextEditingController();
  TasksController tasksController;
  Future<List<Task>> ftasks;
  List<Task> _tasks;

  // String dropdownValue = "Mark";

  @override
  void initState() {
    super.initState();
    tasksController = Provider.of<TasksController>(context, listen: false);
    tasksController.getTask(admin: false, requestedId: widget.id).then((_) {
      setState(() {
        ftasks = Future.value(tasksController.usertasks);
        _tasks = tasksController.usertasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User tasks')),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: FutureBuilder(
            future: ftasks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  _tasks = snapshot.data;
                  return ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key('${index + snapshot.data.length}'),
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        onDismissed: (direction) {
                          Task temp = _tasks[index];
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Item deleted"),
                              action: SnackBarAction(
                                  label: "UNDO",
                                  onPressed: () {
                                    _undoDeletion(index, temp);
                                  }),
                            ),
                          );
                          _deleteTask(widget.id, _tasks[index].id, index);
                        },
                        child: Card(
                          child: ListTile(
                            trailing: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green,
                              ),
                              key: Key(_tasks[index].title),
                              onPressed: () {
                                _updateItem(_tasks[index], index);
                              },
                            ),
                            title: Text(snapshot.data[index].title),
                            subtitle: Text(snapshot.data[index].description),
                            leading: Checkbox(
                              onChanged: (_) {},
                              value: snapshot.data[index].status,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No tasks assigned for this user"));
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
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Item",
        backgroundColor: Colors.redAccent,
        child: ListTile(
          title: Icon(Icons.add),
        ),
        // onPressed: () {},
        onPressed: _showFormDialog,
      ),
    );
  }

  _showFormDialog() {
    _titleEditingController.clear();
    _descEditingController.clear();
    var alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _titleEditingController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Task",
            ),
          ),
          TextField(
            controller: _descEditingController,
            decoration: InputDecoration(
              labelText: "Desciption",
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              _handleSubmitted(
                  _titleEditingController.text, _descEditingController.text);
              Navigator.pop(context);
            },
            child: Text("Save")),
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _handleSubmitted(String title, String desc) async {
    _titleEditingController.clear();
    _descEditingController.clear();
    Task task = Task(
      title: title,
      description: desc,
      status: false,
      committee: widget.committee,
    );
    var key = await tasksController.addTask(widget.id, task);

    setState(() {
      task.id = key;
      _tasks.add(task);
    });
  }

  _updateItem(Task item, int index) {
    _titleEditingController.clear();
    _titleEditingController.text = item.title;
    _descEditingController.clear();
    _descEditingController.text = item.description;
    var alert = AlertDialog(
      title: Text("Update Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _titleEditingController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: "Task",
            ),
          ),
          TextField(
            controller: _descEditingController,
            decoration: InputDecoration(
              labelText: "Desciption",
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () async {
              Task t = Task(
                title: _titleEditingController.text,
                committee: _tasks[index].committee,
                description: _descEditingController.text,
                status: _tasks[index].status,
                id: _tasks[index].id,
              );

              _handleSubmittedUpdate(index, t); //redrawing the screen
              Navigator.pop(context);
            },
            child: Text("Update")),
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  _deleteTask(String userId, String taskId, index) async {
    tasksController.deleteTask(userId, taskId);
    setState(() {
      _tasks.removeAt(index);
    });
  }

  _handleSubmittedUpdate(int index, Task item) {
    tasksController.updateTask(widget.id, item);
    setState(() {
      _tasks[index] = item;
    });
  }

  _undoDeletion(int index, item) async {
    tasksController.updateTask(widget.id, item);
    // await db.saveItem(item);
    setState(() {
      _tasks.insert(index, item);
    });
  }
}
