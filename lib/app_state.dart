import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:snap_bounty/model/player.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/provider/firestore_provider.dart';
import 'package:snap_bounty/view/primary_view.dart';

class PrimaryApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrimaryAppState();

  static PrimaryAppState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PrimaryInheritedWidget)
            as PrimaryInheritedWidget)
        .data;
  }
}

class PrimaryAppState extends State<PrimaryApp> {
  final AuthProvider _authProvider = AuthProvider();
  final FirestoreProvider _firestoreProvider = FirestoreProvider();

  String filter;
  FirebaseUser user;
  Player player;

  void setFilter(String filter) {
    setState(() {
      this.filter = filter;
    });
  }

  String getFilter() {
    return filter;
  }

  void setUserAndPlayer() async {
    FirebaseUser user = await _authProvider.getCurrentUser();
    Player player = await _firestoreProvider.getPlayer(user.uid);

    setState(() {
      this.user = user;
      this.player = player;
    });
  }

  @override
  void initState() {
    super.initState();
    setUserAndPlayer();
    filter = null;
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryInheritedWidget(data: this, child: PrimaryPage());
  }
}

class PrimaryInheritedWidget extends InheritedWidget {
  final PrimaryAppState data;
  final Widget child;

  PrimaryInheritedWidget({this.data, this.child});

  @override
  bool updateShouldNotify(PrimaryInheritedWidget old) => true;

  static PrimaryInheritedWidget of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(PrimaryInheritedWidget);
}
