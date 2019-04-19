import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:snap_hero/model/challenge.dart';
import 'package:snap_hero/view/challenge_view.dart';
import 'package:snap_hero/controller/firestore.dart';

class ChallengeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  StreamBuilder _buildList(BuildContext context) {
    return StreamBuilder(
        stream: getChallenges(),
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
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
            header: GridTileBar(
                title: Text(challenge.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white))),
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
