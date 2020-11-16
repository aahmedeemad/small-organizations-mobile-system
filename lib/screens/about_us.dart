import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('About us'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              'images/tedx.jpg',
              width: 411.4,
              height: 240,
              fit: BoxFit.cover,
            ),
            dataText(),
          ],
        ),
      ),
    );
  }

  Widget dataText() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        'In the spirit of ideas worth spreading,'
        'TED has created a program called TEDx. TEDx'
        'is a program of local, self-organized events'
        'that bring people together to share a TED-like experience.'
        'We are named TEDxMIU, where x = independently organized TED event.'
        'At our TEDxMIU events, TED Talks, video and live speakers will'
        'combine to spark deep discussion and connection in a small group.'
        'The TED Conference provides general guidance for the TEDx program,'
        'but individual TEDx events, including ours, are self-organized.',
        softWrap: true,
      ),
    );
  }
}
