import 'package:flutter/material.dart';

class HomeIconButton extends StatefulWidget {
  final Function onpress;
  final String image;
  final String title;

  const HomeIconButton(
      {@required this.onpress, @required this.image, @required this.title});
  @override
  _HomeIconButtonState createState() => _HomeIconButtonState();
}

class _HomeIconButtonState extends State<HomeIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onpress,
      child: Column(
        children: [
          Image.asset(
            widget.image,
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.fitWidth,
            height: 120,
            color: Colors.grey[800],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.title,
              style: TextStyle(color: Colors.grey[800]),
            ),
          )
        ],
      ),
    );
  }
}
