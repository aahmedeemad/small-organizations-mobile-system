import 'dart:math';
import 'package:flutter/material.dart';

class EvalMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Evaluate members')),
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
                return member(
                  name: "Mark Refaat $index",
                  imagePath:
                      'https://upload.wikimedia.org/wikipedia/commons/3/3f/'
                      'TechCrunch_Disrupt_2019_%2848834434641%29_%28cropped%29.jpg',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget member({@required name, @required imagePath}) {
    return Card(
      elevation: 3.0,
      child: ListTile(
        // leading: Icon(Icons.person),
        leading: new CircleAvatar(
          backgroundColor: Colors.black87,
          minRadius: 10.0,
          maxRadius: 20.0,
          child: new ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: new Image.network(
              imagePath,
            ),
          ),
        ),
        title: Text(name),
        subtitle: StarDisplay(value: Random().nextInt(5)),
        onTap: () {},
      ),
    );
  }
}

class StarDisplay extends StatelessWidget {
  final int value;
  StarDisplay({@required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Icon(
            index < value ? Icons.star : Icons.star_border,
            color: Colors.red,
          );
        }),
      ),
    );
  }
}
