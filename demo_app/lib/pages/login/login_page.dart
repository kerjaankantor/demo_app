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
  bool _isHideToken = true;
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _toggleTokenVisibility() {
    setState(() {
      _isHideToken = !_isHideToken;
    });
  }

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

    final tokenLable = Center(
      child: Text(
        'TOKEN',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..style = PaintingStyle.fill
            ..strokeWidth = 4
            ..color = Colors.blue[700],
        ),
      ),
    );

    final token = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: _isHideToken,
      controller: _text,
      decoration: InputDecoration(
        errorText: _validate ? 'Token Can\'t Be Empty' : null,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        suffixIcon: GestureDetector(
          onTap: () {
            _toggleTokenVisibility();
          },
          child: Icon(
            _isHideToken ? Icons.visibility_off : Icons.visibility,
            color: _isHideToken ? Colors.grey : Colors.blue[600],
          ),
        ),
        isDense: true,
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.lightBlueAccent,
        elevation: 5.0,
        color: Colors.blue[700],
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            setState(() {
              if (_text.text.isEmpty) {
                _validate = true;
              } else {
                _validate = false;
                Navigator.of(context).pushNamed(HomePage.routeName);
              }
            });
          },
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
            SizedBox(height: 40),
            tokenLable,
            SizedBox(height: 20.0),
            token,
            SizedBox(height: 5.0),
            loginButton
          ],
        ),
      ),
    );
  }
}
