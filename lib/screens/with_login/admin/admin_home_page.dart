import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:smallorgsys/widgets/home_icon_button_widget.dart';

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
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
                    image: 'images/admin_home/scan_qr.webp',
                    onpress: () {
                      Navigator.of(context).pushNamed('/scanQr');
                    },
                    title: 'Scan QR',
                  ),
                  HomeIconButton(
                    image: 'images/admin_home/evalution.webp',
                    onpress: () {
                      Navigator.of(context).pushNamed('/evalMembers');
                    },
                    title: 'Evalution',
                  ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeIconButton(
                    image: 'images/admin_home/committees.webp',
                    title: 'Committees',
                    onpress: () {
                      Navigator.of(context).pushNamed('/committeesPage');
                    },
                  ),
                  HomeIconButton(
                    image: 'images/admin_home/statistics.webp',
                    title: 'Statistics',
                    onpress: () {
                      Navigator.of(context).pushNamed('/statisticsPage');
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
}
