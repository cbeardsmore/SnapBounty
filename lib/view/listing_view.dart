import 'package:flutter/material.dart';
import 'package:snap_hero/widgets/gradient_app_bar.dart';
import 'package:snap_hero/widgets/challenge_list.dart';
import 'package:snap_hero/controller/auth.dart';

class PrimaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppBar('Challenges'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => signOut(context),
          ),
        ],
      ),
      body: ChallengeList()
    );
  }
}