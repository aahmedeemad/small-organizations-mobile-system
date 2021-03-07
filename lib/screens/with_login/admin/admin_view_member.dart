import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/user.dart';
import 'package:smallorgsys/providers/users_provider.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:smallorgsys/providers/tasks_provider.dart';

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
          if (res) {
            List usertasks =
                Provider.of<TasksController>(context, listen: false).usertasks;
            print(usertasks);
            int doneTasks =
                usertasks.where((task) => task.status == true).length;
            tasksPercentage = ((doneTasks / usertasks.length) * 100).round();
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
                      child: profilePic(),
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

  Widget eventCard() {
    return InkWell(
      onTap: () {},
      child: Container(
          width: 50,
          height: 100,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.red,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.event, size: 70),
                  title: Text('Upcoming Events',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )),
    );
  }

  Widget profilePic() {
    return Container(
      width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
              image: NetworkImage(user.imagePath), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(75.0)),
          boxShadow: [BoxShadow(blurRadius: 7.0, color: Colors.black)]),
    );
  }

  Widget homeCard({@required word, @required icon}) {
    return Card(
      margin: EdgeInsets.all(10.0),
      color: Colors.grey[300],
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, size: 30.0),
            Text(word, style: TextStyle(fontSize: 18, color: Colors.black)),
          ],
        ),
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
