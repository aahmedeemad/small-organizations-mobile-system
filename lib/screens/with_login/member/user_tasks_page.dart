import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/task.dart';
import 'package:smallorgsys/providers/tasks_provider.dart';
import 'package:smallorgsys/widgets/network_error_widget.dart';
import 'package:smallorgsys/providers/auth.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  List usertasks;

  Future<void> _refresh(context) async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    usertasks = Provider.of<TasksController>(context).usertasks;
    String userid = Provider.of<TasksController>(context).userId;
    var tasksPercentage =
        usertasks.where((u) => u.status == true).length / usertasks.length;
    return FutureBuilder(
        future:
            Provider.of<Auth>(context, listen: false).getTotalAtendedEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasError) {
              return Container(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: tasksPercentage,
                      center: Text(
                        (tasksPercentage * 100).round().toString() + " %",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
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
                        itemCount: usertasks.length,
                        itemBuilder: (context, index) {
                          return taskCard(
                              task: usertasks[index], userid: userid);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else
              return NetworkErrorWidget(retryButton: () => _refresh(context));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget taskCard({@required Task task, @required String userid}) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Checkbox(
          value: task.status,
          onChanged: (val) {
            Provider.of<TasksController>(context, listen: false)
                .changeTaskStatus(task: task, userId: userid)
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
