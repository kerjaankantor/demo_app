import 'package:demo_app/common/route/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'My first App Flutter',
    // home: SplashPage(),
    routes: Routes.routes,
  ));
}
