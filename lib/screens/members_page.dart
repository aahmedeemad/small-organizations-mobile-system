import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IT members')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                labelText: 'Search by name',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return member(name: "Mark Refaat $index", imagePath: null);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget member({@required name, @required imagePath}) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(name),
      ),
    );
  }
}
