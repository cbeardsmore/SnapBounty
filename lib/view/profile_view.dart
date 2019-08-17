import 'package:flutter/material.dart';
import 'package:snap_bounty/model/player.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/provider/firestore_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  final AuthProvider _authProvider = AuthProvider();
  Player player;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    setPlayer();
  }

  void setPlayer() async {
    FirebaseUser user = await _authProvider.getCurrentUser();
    Player player = await _firestoreProvider.getPlayer(user.uid);

    setState(() {
      this.user = user;
      this.player = player;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppBar('Profile'),
      ),
      body: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: 200.0,
              color: Theme.of(context).primaryColor,
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).accentColor,
              ),
            )
          ],
        ),
        _buildPhoto(context),
        _buildDetails(context),
      ]),
    );
  }

  Widget _buildPhoto(BuildContext context) {
    String photoUrl = '';
    if (user != null) {
      photoUrl = user.photoUrl + '?height=500';
    }
    return Positioned(
        top: 100,
        left: MediaQuery.of(context).size.width / 2 - 100,
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(photoUrl), fit: BoxFit.cover),
          ),
        ));
  }

  Widget _buildDetails(BuildContext context) {
    return Positioned(
        top: 300,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
            ),
            _buildDetailsBox(context),
          ],
        ));
  }

  Widget _buildDetailsBox(BuildContext context) {
    if (user == null || player == null)
      return Center(child: CircularProgressIndicator());

    return SizedBox(
      width: 300,
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).iconTheme.color,
                ),
                title: FittedBox(
                    child: Text(
                  user.displayName,
                  style: TextStyle(fontSize: 20),
                  maxLines: 1,
                )),
                trailing: Text('Name', style: TextStyle(fontSize: 10))),
            ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.email),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).iconTheme.color,
                ),
                title: FittedBox(
                    child: Text(
                  user.email,
                  style: TextStyle(fontSize: 20),
                  maxLines: 1,
                )),
                trailing: Text('Email', style: TextStyle(fontSize: 10))),
            ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.star),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).iconTheme.color,
                ),
                title:
                    Text(player.xp.toString(), style: TextStyle(fontSize: 20)),
                trailing: Text('XP', style: TextStyle(fontSize: 10))),
          ],
        ),
      ),
    );
  }
}
