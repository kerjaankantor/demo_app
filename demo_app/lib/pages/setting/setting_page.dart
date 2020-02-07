import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingPage();
  }
}

class _SettingPage extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Setting"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Image.asset(
              "images/logo.png",
              width: 200.0,
              height: 100.0,
            ),
            SizedBox(height: 40.0),
            Center(
              child: Text(
                'Setting...Page',
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.blue[700],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Image.asset(
              "images/loading.gif",
              width: 200.0,
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
