import 'package:demo_app/common/system-constant/system-constant.dart';
import 'package:demo_app/pages/home/home_page.dart';
import 'package:demo_app/pages/login/login_page.dart';
import 'package:demo_app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class Routes{
  static final routes =<String, WidgetBuilder>{
    SystemConstants.INITIAL_PAGE : (BuildContext context)=> SplashPage(),
    SystemConstants.LOGIN_PAGE : (BuildContext context)=> LoginPage(),
    SystemConstants.HOME_PAGE : (BuildContext context)=> HomePage()
    // SystemConstants.MOVIE_DETAIL : (BuildContext context)=> MovieDetailPage(String id),
  };
}