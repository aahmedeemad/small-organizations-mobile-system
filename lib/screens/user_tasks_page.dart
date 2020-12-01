import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 13.0,
            animation: true,
            percent: 0.8,
            center: Text(
              "80.0%",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: Text(
              "Finished Tasks",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.red,
          ),
          Divider(),
          Center(child: Text("Your tasks")),
          Divider(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return taskCard(
                  title: "Task ${index + 1}",
                  description: "Task ${index + 1} description",
                  checkbox: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget taskCard(
      {@required title, @required description, @required checkbox}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: Checkbox(
          value: checkbox,
          onChanged: (val) {
            print(val);
          }),
    );
  }
}
