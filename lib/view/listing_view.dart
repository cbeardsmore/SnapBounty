import 'package:flutter/material.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:snap_bounty/widgets/challenge_list.dart';
import 'package:snap_bounty/provider/auth_provider.dart';

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
        ],
      ),
      body: ChallengeList()
    );
  }
}