import 'package:flutter/material.dart';
import 'package:snap_bounty/model/player.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/provider/firestore_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  final AuthProvider _authProvider = AuthProvider();
  Player player;
  String photoUrl;

  @override
  void initState() {
    super.initState();
    setPlayer();
  }

  void setPlayer() async {
    String playerId = await _authProvider.getUserId();
    String photoUrl = await _authProvider.getUserPhotoUrl();
    Player player = await _firestoreProvider.getPlayer(playerId);
    setState(() {
      this.player = player;
      this.photoUrl = photoUrl;
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
    return Positioned(
        top: 100,
        left: MediaQuery.of(context).size.width / 2 - 100,
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(photoUrl ?? ''), fit: BoxFit.cover),
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
    String xp = player == null ? '0' : player.xp.toString();

    return SizedBox(
      width: 300,
      child: new Card(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(Icons.star),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).iconTheme.color,
              ),
              title: new Text(xp, style: TextStyle(fontSize: 20)),
              trailing: new Text('XP', style: TextStyle(fontSize: 10)),
            )
          ],
        ),
      ),
    );
  }
}
