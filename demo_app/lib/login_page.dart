import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
        color: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
           
          },
          color: Colors.lightBlueAccent,
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
           token,
           loginButton
         ],
       ),
     ),
    );
  }
}
