import 'dart:async';

import 'package:demo_app/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return LoginPage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                'My Video App',
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
