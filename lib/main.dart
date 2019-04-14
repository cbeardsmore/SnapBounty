import 'package:flutter/material.dart';
import 'package:snap_hero/view/auth_view.dart';
import 'package:snap_hero/view/listing_view.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'snapHero',
      theme: new ThemeData(
        primaryColor: Color(0xFF18FFFF),
        primaryColorLight: Color(0xFF76FFFF),
        primaryColorDark: Color(0xFF00CBCC),
        accentColor: Color(0XFF37464F),
        cardColor: Colors.grey[300],
        iconTheme: new IconThemeData(color: Colors.black),
      ),
      home: new AuthPage(),
      routes: {
        "/auth": (_) => AuthPage(),
        "/primary": (_) => PrimaryPage(),
      },
    );
  }
}
