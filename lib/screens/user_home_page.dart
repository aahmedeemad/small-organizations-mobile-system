import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  homeIcon(
                    image: 'https://cdn2.iconfinder.com/data/icons/scan-to-pay/'
                        '512/scan-pay-payment-01-512.png',
                    title: 'QR Code',
                    onpress: () {},
                  ),
                  homeIcon(
                    image: 'https://cdn0.iconfinder.com/data/icons/app-pack-1-'
                        'musket-monoline/32/app-17-clipboard-512.png',
                    title: 'Tasks',
                    onpress: () {},
                  ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  homeIcon(
                    image: 'https://cdn2.iconfinder.com/data/icons/productivit'
                        'y/256/Working_Schedule-512.png',
                    title: 'Calendar',
                    onpress: () {},
                  ),
                  homeIcon(
                    image: 'https://cdn3.iconfinder.com/data/icons/eldorado-'
                        'stroke-work/40/profile_2-512.png',
                    title: 'Profile',
                    onpress: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget homeIcon({@required image, @required title, @required onpress}) {
    return InkWell(
      onTap: onpress,
      child: Column(
        children: [
          Image.network(
            image,
            repeat: ImageRepeat.noRepeat,
            fit: BoxFit.fitWidth,
            height: 120,
            color: Colors.white60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white60),
            ),
          )
        ],
      ),
    );
  }
}
