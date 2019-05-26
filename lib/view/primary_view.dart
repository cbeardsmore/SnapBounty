import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:snap_bounty/app_state.dart';
import 'package:snap_bounty/model/player.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/widgets/challenge_list.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';

class PrimaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PrimaryInheritedWidget _primaryInheritedWidget =
        PrimaryInheritedWidget.of(context);
    final Player player = _primaryInheritedWidget.data.player;

    List<Widget> bodyStack = [ChallengeList()];
    if (!player.tutorialComplete) {
      bodyStack.add(Text('ssdsdsdsd'));
    }

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('Challenges'),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildUserDrawerHeader(context),
            _buildFilters(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            _buildButtons(context),
          ],
        )),
        body: Stack(
          children: bodyStack,
        ));
  }

  Widget _buildUserDrawerHeader(BuildContext context) {
    final PrimaryInheritedWidget _primaryInheritedWidget =
        PrimaryInheritedWidget.of(context);
    final FirebaseUser user = _primaryInheritedWidget.data.user;

    return UserAccountsDrawerHeader(
      accountEmail: Text(user != null ? user?.email : ''),
      accountName: Text(user != null ? user.displayName : ''),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user != null ? user.photoUrl : ''),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
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
                _buildFilterChip(context, 'Activities'),
                _buildFilterChip(context, 'Animals'),
                _buildFilterChip(context, 'Food & Drink'),
                _buildFilterChip(context, 'Home'),
                _buildFilterChip(context, 'People'),
                _buildFilterChip(context, 'Places'),
                _buildFilterChip(context, 'Things'),
                _buildFilterChip(context, 'Transport')
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label) {
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

  Widget _buildButtons(BuildContext context) {
    final AuthProvider _authProvider = AuthProvider();
    return ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        onTap: () => _authProvider.signOut(context));
  }
}
