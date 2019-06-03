import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:snap_bounty/app_state.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/view/auth_view.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MainApp());
  });
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapBounty',
      theme: ThemeData(
        primaryColor: Color(0xFF18FFFF),
        primaryColorLight: Color(0xFF76FFFF),
        primaryColorDark: Color(0xFF00CBCC),
        accentColor: Color(0XFF37464F),
        cardColor: Colors.grey[300],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    final AuthProvider _authProvider = AuthProvider();

    return StreamBuilder<FirebaseUser>(
        stream: _authProvider.getAuthStateStream(),
        builder: (BuildContext context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return PrimaryApp();
            }
            return AuthPage();
          }
        });
  }
}
