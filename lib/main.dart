import 'package:flutter/material.dart';
import 'screens/auth_page.dart';
import 'screens/home_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'snapHero',
      theme: new ThemeData(
        primaryColor: Colors.yellow,
        accentColor: Colors.yellow,
        cardColor: Colors.grey[300],
        iconTheme: new IconThemeData(color: Colors.black),
        dividerColor: Colors.black,
      ),
      home: new AuthPage(),
      routes: {
        "/auth": (_) => AuthPage(),
        "/primary": (_) => PrimaryPage(),
      },
    );
  }
}
