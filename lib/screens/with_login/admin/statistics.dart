import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:smallorgsys/providers/auth.dart';
import 'package:smallorgsys/providers/tasks_provider.dart';
import 'package:smallorgsys/widgets/network_error_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: FutureBuilder(
          future: _refresh(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasError) {
                Map stats = Provider.of<TasksController>(context, listen: false)
                    .tasksStat();

                return ListView(
                  children: [
                    chartWidget(
                        committeName: 'IT departement',
                        data: stats['IT'] != null ? stats['IT'] : [0, 0]),
                    chartWidget(
                        committeName: 'HR departement',
                        data: stats['HR'] != null ? stats['HR'] : [0, 0]),
                    chartWidget(
                        committeName: 'PR departement',
                        data: stats['PR'] != null ? stats['PR'] : [0, 0]),
                    chartWidget(
                        committeName: 'Media departement',
                        data: stats['Media'] != null ? stats['Media'] : [0, 0]),
                  ],
                );
              } else
                return NetworkErrorWidget(retryButton: () => _refresh(context));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Future<void> _refresh(context) async {
    await Provider.of<TasksController>(context, listen: false)
        .getAllTasks(admin: Provider.of<Auth>(context, listen: false).isAdmin);
  }
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
          PieChart(dataMap: {
            'completed': data[0].toDouble(),
            'In progress': data[1].toDouble()
          }),
          // Divider(color: Colors.red),
        ],
      ),
    ),
  );
}
