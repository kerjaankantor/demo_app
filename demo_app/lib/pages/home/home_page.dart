import 'package:demo_app/pages/dashboard/dashboard_page.dart';
import 'package:demo_app/pages/favorite/favorite_page.dart';
import 'package:demo_app/pages/search/search_page.dart';
import 'package:demo_app/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      DashboardPage(),
      SearchPage(),
      FavoritePage(),
      SettingPage(),
    ];

    final _bottomNavBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.dashboard), title: Text('Dashboard')),
      BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite), title: Text('Favorite')),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings), title: Text('Setting')),
    ];

    final _bottomNavBar = BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onNavBarTapped);

    return Scaffold(
      body: Center(
        child: _listPage[_selectedTabIndex],
      ),
      // drawer: _buildDrawer(),
      bottomNavigationBar: _bottomNavBar,
      // endDrawer: _buildDrawer(),
    );
  }
}
