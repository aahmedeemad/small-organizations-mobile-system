import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

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
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  homeIcon(
                    image: 'https://cdn2.iconfinder.com/data/icons/scan-to-pay/'
                        '512/scan-pay-payment-01-512.png',
                    title: 'Scan QR',
                    onpress: _scan,
                  ),
                  homeIcon(
                    image: 'https://cdn0.iconfinder.com/data/icons/stem-science'
                        '-technology-engineering-math-education/64/team-teamwork-members-group-people-mass-256.png',
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
                  homeIcon(
                    image: 'https://cdn0.iconfinder.com/data/icons/'
                        'human-resource-1-3/66/47-512.png',
                    title: 'Add Task',
                    onpress: () {
                      Navigator.of(context).pushNamed('/addTask');
                    },
                  ),
                  homeIcon(
                    image: 'https://cdn2.iconfinder.com/data/icons/user-actions'
                        '-line/24/add_user_member_friend-256.png',
                    title: 'Add new member',
                    onpress: () {
                      Navigator.of(context).pushNamed('/addMember');
                    },
                  ),
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
          Image.network(
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

  Future _scan() async {
    String barcode = await scanner.scan();
    // this._outputController.text = barcode;
  }
}
