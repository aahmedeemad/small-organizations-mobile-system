import 'package:flutter/material.dart';

class CommitteesPage extends StatefulWidget {
  @override
  _CommitteesPageState createState() => _CommitteesPageState();
}

class _CommitteesPageState extends State<CommitteesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Committees'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          committeeCard(name: 'HR'),
          committeeCard(name: 'IT'),
          committeeCard(name: 'PR'),
          committeeCard(name: 'Media'),
        ],
      ),
    );
  }

  Widget committeeCard({@required name}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/membersPage');
        },
        child: Card(
          elevation: 5.0,
          child: Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 22.0),
            ),
          ),
        ),
      ),
    );
  }
}
