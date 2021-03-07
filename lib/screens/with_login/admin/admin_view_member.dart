import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/user.dart';
import 'package:smallorgsys/providers/users_provider.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:smallorgsys/providers/tasks_provider.dart';
import 'package:smallorgsys/widgets/user_profile_widgets.dart';

class AdminViewMember extends StatefulWidget {
  final String id;
  AdminViewMember(this.id);

  @override
  _AdminViewMemberState createState() => _AdminViewMemberState();
}

class _AdminViewMemberState extends State<AdminViewMember> {
  int totalAtendedEvents;
  int tasksPercentage;
  bool _isLoading = true;
  @override
  void initState() {
    Provider.of<Auth>(context, listen: false)
        .getTotalAtendedEvents(admin: true, userId: widget.id)
        .then((res) {
      print(res['success']);
      if (res['success']) {
        totalAtendedEvents = res['totalAtendedEvents'];
        Provider.of<TasksController>(context, listen: false)
            .getTask(admin: true, requestedId: widget.id)
            .then((res) {
          print(res);
          if (res != null) {
            List usertasks =
                Provider.of<TasksController>(context, listen: false).usertasks;

            int doneTasks =
                usertasks.where((task) => task.status == true).length;
            tasksPercentage = ((doneTasks / usertasks.length) * 100).round();
            setState(() {
              _isLoading = false;
            });
          } else {
            tasksPercentage = 0;
            setState(() {
              _isLoading = false;
            });
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
    user = Provider.of<UsersController>(context, listen: false)
        .users
        .firstWhere((user) => user.id == widget.id);
    print(user);
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
}
