import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsPage extends StatelessWidget {
  final Map<String, double> dataIT = {
    "Completed": 10,
    "Not Completed": 3,
  };
  final Map<String, double> dataHR = {
    "Completed": 5,
    "Not Completed": 1,
  };
  final Map<String, double> dataPR = {
    "Completed": 4,
    "Not Completed": 6,
  };
  final Map<String, double> dataMedia = {
    "Completed": 1,
    "Not Completed": 8,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: ListView(
        children: [
          chartWidget(committeName: 'IT departement', data: dataIT),
          chartWidget(committeName: 'HR departement', data: dataHR),
          chartWidget(committeName: 'PR departement', data: dataPR),
          chartWidget(committeName: 'Media departement', data: dataMedia),
        ],
      ),
    );
  }

  Widget chartWidget({@required committeName, @required data}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  committeName,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            PieChart(dataMap: data),
            // Divider(color: Colors.red),
          ],
        ),
      ),
    );
  }
}
