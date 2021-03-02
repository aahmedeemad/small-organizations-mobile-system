import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallorgsys/models/event.dart';
import 'package:smallorgsys/providers/event_provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScanQrPage extends StatefulWidget {
  @override
  _ScanQrPageState createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  String selectedEvent;
  EventsController providerEventsController;
  String name, imagePath;
  @override
  void initState() {
    super.initState();
    Provider.of<EventsController>(context, listen: false)
        .fetchAndSetEvents()
        .then((_) {
      selectedEvent = providerEventsController?.events[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    providerEventsController = Provider.of<EventsController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Qr"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text("Choose event"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: new DropdownButton<String>(
                value: selectedEvent,
                items: providerEventsController.events.map((Event value) {
                  return new DropdownMenuItem<String>(
                    value: value.id,
                    child: new Text(value.title),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedEvent = val;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: IconButton(
                icon: Icon(
                  Icons.camera,
                  size: 40,
                ),
                onPressed: _scan,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
            ),
            imagePath != null
                ? SizedBox(
                    width: 20.0,
                    height: 150.0,
                    child: Image.network(imagePath),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 22),
            ),
            name != null
                ? Center(
                    child: Text(
                    name,
                    style: Theme.of(context).textTheme.headline5,
                  ))
                : Container(),
          ],
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode != null)
      providerEventsController
          .userAttendEvent(selectedEvent, barcode)
          .then((result) {
        if (result['success']) {
          setState(() {
            name = result['user_name'];
            imagePath = result['user_imagePath'];
          });
        } else {
          setState(() {
            name = "Error adding this user";
            imagePath = null;
          });
        }
      });
    // this._outputController.text = barcode;
  }
}
