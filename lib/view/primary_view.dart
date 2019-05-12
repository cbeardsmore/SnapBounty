import 'package:flutter/material.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:snap_bounty/widgets/challenge_list.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  String filter;

  void setFilter(String filter) {
    setState(() {
      this.filter = filter;
    });
  }

  @override
  void initState() {
    super.initState();
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
    final PrimaryInheritedWidget _primaryInheritedWidget = PrimaryInheritedWidget.of(context);
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
                backgroundImage:
                    NetworkImage(user != null ? user.photoUrl : ''),
              ),
            ),
            RaisedButton(
              child: Text('press me'),
              onPressed: () => _primaryInheritedWidget.data.setFilter('Activities'),
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
