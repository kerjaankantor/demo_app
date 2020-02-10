import 'package:demo_app/common/system-constant/system-constant.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingPage();
  }
}

class _SettingPage extends State<SettingPage> {
  bool isFavorite = false;

  void _onSwitchChanged(bool value) {
    isFavorite = false;
  }

  @override
  Widget build(BuildContext context) {
    Widget viewOptionSection = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text("View"),
        Switch(value: isFavorite, onChanged: _onSwitchChanged),
      ],
    );

    Widget logoutButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.lightBlueAccent,
        elevation: 5.0,
        color: Colors.blue[700],
        child: MaterialButton(
          minWidth: 10.0,
          height: 42.0,
          onPressed: () {
            setState(() {
              Navigator.of(context).pushNamed(SystemConstants.LOGIN_PAGE);
            });
          },
          child: Text('Log out', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: new Icon(Icons.settings,color:Colors.blue[700],),
        title: Text("Setting", style: TextStyle(color: Colors.blue[700], )),
         backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
         shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[viewOptionSection, logoutButton],
      ),
    );
  }
}
