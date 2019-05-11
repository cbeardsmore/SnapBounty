import 'package:flutter/material.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:snap_bounty/widgets/challenge_list.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/view/profile_view.dart';

class PrimaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider = AuthProvider();

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('Challenges'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => _authProvider.signOut(context),
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  ),
            ),
          ],
        ),
        body: ChallengeList());
  }
}
