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

  String getFilter() {
    return filter;
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
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('Challenges'),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildUserDrawerHeader(),
            _buildFilters(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            _buildButtons(),
          ],
        )),
        body: ChallengeList());
  }

  Widget _buildUserDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountEmail: Text(user != null ? user?.email : ''),
      accountName: Text(user != null ? user.displayName : ''),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user != null ? user.photoUrl : ''),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(
              'Category Filter',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              spacing: 5,
              runSpacing: -5,
              children: <Widget>[
                _buildFilterChip('Activities'),
                _buildFilterChip('Animals'),
                _buildFilterChip('Home'),
                _buildFilterChip('People'),
                _buildFilterChip('Places'),
                _buildFilterChip('Things'),
                _buildFilterChip('Transport')
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final PrimaryInheritedWidget _primaryInheritedWidget =
        PrimaryInheritedWidget.of(context);

    return FilterChip(
        label: Text(label),
        backgroundColor: Theme.of(context).cardColor,
        selectedColor: Colors.grey[600],
        selected: _primaryInheritedWidget.data.getFilter() == label,
        onSelected: (isSelected) {
          String newFilter = isSelected ? label : null;
          _primaryInheritedWidget.data.setFilter(newFilter);
        });
  }

  Widget _buildButtons() {
    return ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        onTap: () => _authProvider.signOut(context));
  }
}
