import 'package:flutter/material.dart';
import 'package:flutter_blog_app/LoginRegisterPage.dart';
import 'package:flutter_blog_app/homePage.dart';
import 'package:flutter_blog_app/wifiApp/wifi_app.dart';

import 'blog2app/home_page.dart';
import 'firestoreApp/home3.dart';
import 'wallpaperApp/wallpaper_app.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

void main() => runApp(BlogApp());

class BlogApp extends StatelessWidget {
  //for firebase analytics
  static FirebaseAnalytics analytics = new FirebaseAnalytics();
    static FirebaseAnalyticsObserver observer =
      new FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'blog app',
      theme:ThemeData(
       primarySwatch: Colors.pink
      ),
      //analytics
      
      navigatorObservers: <NavigatorObserver>[observer],
      home: WallpaperAppHome(observer:observer,analytics:analytics),
    );
  }
}