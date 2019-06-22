import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:snap_bounty/app_state.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/widgets/challenge_list.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:snap_bounty/view/tutorial_view.dart';
import 'package:snap_bounty/view/donate_view.dart';

class PrimaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('Challenges'),
        ),
        drawer: Drawer(
            child: Column(
          children: <Widget>[
            _buildUserDrawerHeader(context),
            _buildFilters(context),
            _buildButtons(context),
          ],
        )),
        body: ChallengeList());
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
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              'Category Filter',
              style: TextStyle(fontSize: 20),
            ),
            Divider(
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
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: <Widget>[
          Divider(height: 10),
                    ListTile(
              leading: Icon(Icons.favorite, color: Colors.red),
              title: Text(
                'Support the Developer',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DonationsPage()))),
          // ListTile(
          //     leading: Icon(Icons.help),
          //     title: Text(
          //       'How to Play',
          //       style: TextStyle(fontSize: 16),
          //     ),
          //     onTap: () => Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => TutorialPage()))),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                'Sign Out',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => _authProvider.signOut(context)),
        ],
      ),
    );
  }
}
