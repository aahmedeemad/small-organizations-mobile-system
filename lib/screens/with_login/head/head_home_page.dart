import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:smallorgsys/widgets/home_icon_button_widget.dart';

class HeadHomePage extends StatefulWidget {
  @override
  _HeadHomePageState createState() => _HeadHomePageState();
}

class _HeadHomePageState extends State<HeadHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Head Home Page'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logout();
              })
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeIconButton(
                    image: 'images/head_home/scan_qr.webp',
                    title: 'Scan QR',
                    onpress: () {
                      Navigator.of(context).pushNamed('/scanQr');
                    },
                  ),
                  HomeIconButton(
                    image: 'images/head_home/committee.webp',
                    title: 'Members',
                    onpress: () {
                      Navigator.of(context).pushNamed('/membersPage');
                    },
                  ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeIconButton(
                    image: 'images/head_home/add_task.webp',
                    title: 'Add Task',
                    onpress: () {
                      Navigator.of(context).pushNamed('/addTask');
                    },
                  ),
                  // homeIcon(
                  //   image: 'https://cdn2.iconfinder.com/data/icons/user-actions'
                  //       '-line/24/add_user_member_friend-256.png',
                  //   title: 'Add new member',
                  //   onpress: () {
                  //     Navigator.of(context).pushNamed('/addMember');
                  //   },
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget homeIcon({@required image, @required title, @required onpress}) {
    return InkWell(
      onTap: onpress,
      child: Column(
        children: [
          Image.asset(
            image,
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.fitWidth,
            height: 120,
            color: Colors.grey[800],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey[800]),
            ),
          )
        ],
      ),
    );
  }
}
