import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
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
                    title: 'Scan QR',
                    onpress: _scan,
                  ),
                  homeIcon(
                    image: 'https://cdn0.iconfinder.com/data/icons/'
                        'human-resource-1-3/66/47-512.png',
                    title: 'Evalution',
                    onpress: () {},
                  ),
                ],
              ),
              SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  homeIcon(
                    image: 'https://cdn4.iconfinder.com/data/icons/company-str'
                        'ucture-6/64/directors-board-committee-administration-organization-512.png',
                    title: 'Committees',
                    onpress: () {
                      Navigator.of(context).pushNamed('/committeesPage');
                    },
                  ),
                  homeIcon(
                    image: 'https://cdn0.iconfinder.com/data/icons/human-reso'
                        'urce-management-5/64/sq482_human_resource_reporting_statistics_find_analyze_insights-512.png',
                    title: 'Statistics',
                    onpress: () {
                      Navigator.of(context).pushNamed('/statisticsPage');
                    },
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
            color: Colors.grey[800],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey[800]),
            ),
          )
        ],
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    // this._outputController.text = barcode;
  }
}
