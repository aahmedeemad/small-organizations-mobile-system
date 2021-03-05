import 'package:flutter/material.dart';

class NetworkErrorWidget extends StatefulWidget {
  final Function retryButton;
  NetworkErrorWidget({@required this.retryButton});

  @override
  _NetworkErrorWidgetState createState() => _NetworkErrorWidgetState();
}

class _NetworkErrorWidgetState extends State<NetworkErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('An error occurred while retrieving data,'),
          Text('Please check your network connection!'),
          RaisedButton(
            child: Text("Retry"),
            onPressed: widget.retryButton,
          )
        ],
      ),
    );
  }
}
