import 'package:demo_app/common/system-constant/system-constant.dart';
import 'package:demo_app/data/movie/datasources/search_movie_datasource_shared_preferencelocal_impl.dart';
import 'package:demo_app/data/movie/models/setting.dart';
import 'package:demo_app/data/movie/repositories/movie_repositories.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingPage();
  }
}

class _SettingPage extends State<SettingPage> {
  bool isFavorite = true;
  static final String HIDDEN_KEY = "setting_key";
  static final String HIDDEN_VALUE = "_hidden";
  static final String SHOWED_VALUE = "_showed";
  SettingFav settingFav;

  Future<MovieRepository> get movieDetailLocalRepository async =>
      MovieRepositoryImpl(
          movieDetailLocalDatasource: MovieLocalDatasourceSharedPrefetenceImpl(
              sharedPreferences: await SharedPreferences.getInstance()));
  @override
  void initState() {
    super.initState();
    _onGetHiddenSetting(HIDDEN_KEY);
  }

  void _onSwitchChanged(bool value) {
    isFavorite = value;
    _onSaveSetting(HIDDEN_KEY, isFavorite ? SHOWED_VALUE : HIDDEN_VALUE);
  }

  _onSaveSetting(String key, String value) async {
    try {
      final repository = await movieDetailLocalRepository;
      if (mounted) {
        repository.setHiddenRec(key, value);
      }
    } catch (e) {
      print(e);
    }
  }

  _onGetHiddenSetting(String key) async {
    try {
      final repository = await movieDetailLocalRepository;
      if (mounted) {
        SettingFav result = await repository.getHiddenFav(key);
        setState(() {
          settingFav = result;
          if (settingFav != null) {
            isFavorite =
                settingFav.hiddenVal.toString() == SHOWED_VALUE ? true : false;
          }
        });
      }
    } catch (e) {
      print(e);
      if (mounted) {
        setState(() {
          settingFav = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget viewOptionSection = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text("Show  Recommended",
            style: TextStyle(
              color: Colors.blue[700],
              fontSize: 18.0,
            )),
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
        leading: new Icon(
          Icons.settings,
          color: Colors.blue[700],
        ),
        title: Text("Setting",
            style: TextStyle(
              color: Colors.blue[700],
            )),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0),
          children: <Widget>[viewOptionSection, logoutButton],
        ),
      ),
    );
  }
}
