import 'package:demo_app/pages/home/home_page.dart';
import 'package:demo_app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

void main() {

  final routes = <String, WidgetBuilder>{
    HomePage.routeName: (context) => HomePage(),
  };

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'My first App Flutter',
    home: SplashPage(),
    routes: routes,
  ));
}