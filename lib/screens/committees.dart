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
      body: ListView(
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
    return Card(
      child: ListTile(
        title: Text(name),
        onTap: () {
          Navigator.of(context).pushNamed('/membersPage');
        },
      ),
    );
  }
}
