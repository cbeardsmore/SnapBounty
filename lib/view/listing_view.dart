import 'package:flutter/material.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:snap_bounty/widgets/challenge_list.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrimaryPage extends StatelessWidget {
  final FirebaseUser user;

  PrimaryPage({this.user});

  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider = AuthProvider();

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('Challenges'),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(user.email),
              accountName: Text(user.displayName),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            Divider(height: 5),
            ListTile(
              leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: () => _authProvider.signOut(context)),
          ],
        )),
        body: ChallengeList());
  }
}
