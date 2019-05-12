import 'package:flutter/material.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:snap_bounty/widgets/challenge_list.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrimaryPage extends StatefulWidget {

  @override
  _PrimaryPageState createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  final AuthProvider _authProvider = AuthProvider();

  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    setUser();
  }

  void setUser() async {
    FirebaseUser user = await _authProvider.getCurrentUser();
    setState(() {
      this.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('Challenges'),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(user != null ? user.email : ''),
              accountName: Text(user != null ? user.displayName : ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user != null ? user.photoUrl : ''),
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
