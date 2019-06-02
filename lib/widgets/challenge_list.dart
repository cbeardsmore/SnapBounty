import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:snap_bounty/app_state.dart';
import 'package:snap_bounty/model/challenge.dart';
import 'package:snap_bounty/model/player.dart';
import 'package:snap_bounty/provider/firestore_provider.dart';
import 'package:snap_bounty/view/challenge_view.dart';

class ChallengeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  StreamBuilder _buildList(BuildContext context) {
    final FirestoreProvider _firestoreProvider = FirestoreProvider();
    final PrimaryInheritedWidget _primaryInheritedWidget =
        PrimaryInheritedWidget.of(context);
    String filter = _primaryInheritedWidget?.data?.filter;

    return StreamBuilder(
        stream: _firestoreProvider.getChallenges(filter: filter),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: const CircularProgressIndicator());
          return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                Challenge challenge =
                    Challenge.fromDocument(snapshot.data.documents[index]);
                return _buildListItem(context, challenge);
              });
        });
  }

  Card _buildListItem(BuildContext context, Challenge challenge) {
    final PrimaryInheritedWidget _primaryInheritedWidget =
        PrimaryInheritedWidget.of(context);
    final Player player = _primaryInheritedWidget?.data?.player;
    final List<String> completedChallenges = player?.completed;

    bool completed = completedChallenges != null &&
        completedChallenges.contains(challenge.id);

    BorderSide side = completed
        ? BorderSide(color: Colors.lightGreenAccent[400], width: 5)
        : BorderSide.none;

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), side: side),
      clipBehavior: Clip.none,
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChallengePage(challenge)),
          );
        },
        child: GridTile(
            header: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.topLeft,
              child: GridTileBar(
                leading: Chip(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  label: Text(challenge.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: challenge.image,
                  fit: BoxFit.cover,
                ))),
      ),
    );
  }
}
