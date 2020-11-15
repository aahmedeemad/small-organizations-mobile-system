import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<String> dropdownValues = ['Mark', 'Fady', 'Ahmed', 'Mohamed'];
  String dropdownValue = "Mark";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new task')),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Task name",
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Task description",
                ),
              ),
              new DropdownButton<String>(
                items: dropdownValues.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                value: dropdownValue,
                onChanged: (_) {
                  setState(() {
                    dropdownValue = _;
                  });
                },
              ),
              MaterialButton(
                onPressed: () {},
                child: Text("Add"),
                color: Colors.red,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
