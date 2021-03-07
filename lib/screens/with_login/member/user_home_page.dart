import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/user.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:smallorgsys/providers/tasks_provider.dart';
import 'package:smallorgsys/widgets/network_error_widget.dart';
import 'package:smallorgsys/widgets/user_profile_widgets.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int totalAtendedEvents;
  int tasksPercentage;
  Future attendedEvents;
  @override
  void initState() {
    attendedEvents = Provider.of<Auth>(context, listen: false)
        .getTotalAtendedEvents()
        .then((res) {
      if (res['success']) {
        totalAtendedEvents = res['totalAtendedEvents'];
        Provider.of<TasksController>(context, listen: false)
            .getTask(
                admin: false,
                requestedId: Provider.of<Auth>(context, listen: false).user.id)
            .then((res) {
          if (res) {
            List usertasks =
                Provider.of<TasksController>(context, listen: false).usertasks;

            int doneTasks =
                usertasks.where((task) => task.status == true).length;
            tasksPercentage = ((doneTasks / usertasks.length) * 100).round();
            setState(() {});
          }
        });
      }
    });
    super.initState();
  }

  Uint8List bytes = Uint8List(0);
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<Auth>(context, listen: false).user;
    return FutureBuilder(
        future: attendedEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              tasksPercentage != null) {
            if (!snapshot.hasError) {
              return Scaffold(
                body: ListView(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(25.0),
                          child: profilePic(image: user.imagePath),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Text(
                                user.name,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                user.committee + " " + user.privilege,
                                style: TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                tooltip: 'Qr Code',
                                icon: Icon(Icons.qr_code),
                                iconSize: 30,
                                onPressed: () {
                                  showQr(context);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    homeCard(
                        word: ' Tasks done $tasksPercentage%',
                        icon: Icons.pending_actions),
                    // homeCard(
                    //     word: ' Attendance Meetings 70%', icon: Icons.pending_actions),
                    homeCard(
                        word: ' Attended $totalAtendedEvents events ',
                        icon: Icons.event),
                    // eventCard(),
                    SizedBox(height: 15),
                    Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Your Information",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        user.email,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "TEDx-er since ${user.joinAt}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        user.phone,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Your evaluation " + user.rating.toString() + " 🌟",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 18),
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

  Future showQr(context) async {
    Uint8List result = await scanner.generateBarCode(user.id);
    this.setState(() => this.bytes = result);
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          "Your QR Code",
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 200,
          width: 200,
          child: Image.memory(bytes),
        ),
      ),
    );

    //due to flutter upgrade
    /*return showDialog(
      context: context,
      child: AlertDialog(
        title: Text(
          "Your QR Code",
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 200,
          width: 200,
          child: Image.memory(bytes),
        ),
      ),
    );*/
  }

  Future<void> _refresh(context) async {
    setState(() {
      attendedEvents = Provider.of<Auth>(context, listen: false)
          .getTotalAtendedEvents()
          .then((res) {
        if (res['success']) {
          totalAtendedEvents = res['totalAtendedEvents'];
          Provider.of<TasksController>(context, listen: false)
              .getTask(
                  admin: false,
                  requestedId:
                      Provider.of<Auth>(context, listen: false).user.id)
              .then((res) {
            if (res) {
              List usertasks =
                  Provider.of<TasksController>(context, listen: false)
                      .usertasks;
              int doneTasks =
                  usertasks.where((task) => task.status == true).length;
              tasksPercentage = ((doneTasks / usertasks.length) * 100).round();
              setState(() {});
            }
          });
        }
      });
    });
  }
}
