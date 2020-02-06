import 'package:demo_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'login-page';
  @override
  State<StatefulWidget> createState() {
    return new _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset(
          "images/logo.png",
          width: 200.0,
          height: 100.0,
        ),
      ),
    );

    final token = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: 'type any key',
      decoration: InputDecoration(
        hintText: 'type any key',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0),
      child: Material(
        color: Colors.grey,
        elevation: 1.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            print(HomePage.routeName);
            Navigator.of(context).pushNamed(HomePage.routeName);
          },
          color: Colors.blue[600],
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 40.0),
            token,
            SizedBox(height: 20),
            loginButton
          ],
        ),
      ),
    );
  }
}
