import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/task.dart';
import 'package:smallorgsys/models/user.dart';
import 'package:smallorgsys/providers/auth.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  bool _isLoading = true;
  User authUser;

  @override
  void initState() {
    super.initState();
    Provider.of<Auth>(context, listen: false).getTask().then((res) {
      if (res) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    authUser = Provider.of<Auth>(context).user;
    var tasksPercentage = authUser.tasks.where((u) => u.status == true).length /
        authUser.tasks.length;
    return Container(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(height: 15),
                CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: tasksPercentage,
                  center: Text(
                    (tasksPercentage * 100).round().toString() + " %",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  footer: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Finished Tasks",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: tasksPercentage <= 0.25
                      ? Colors.red
                      : tasksPercentage <= 0.5
                          ? Colors.orange
                          : tasksPercentage <= 0.75
                              ? Colors.yellow
                              : Colors.green,
                ),
                SizedBox(height: 15),
                Divider(),
                Center(child: Text("Your tasks")),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: authUser.tasks.length,
                    itemBuilder: (context, index) {
                      return taskCard(
                        task: authUser.tasks[index],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget taskCard({@required Task task}) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
          value: task.status,
          onChanged: (val) {
            Provider.of<Auth>(context, listen: false)
                .changeTaskStatus(task)
                .then((res) {
              if (res == true)
                setState(() {
                  task.status = !task.status;
                });
            });
          }),
    );
  }
}
