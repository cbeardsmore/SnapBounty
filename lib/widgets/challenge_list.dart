import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:snap_bounty/model/challenge.dart';
import 'package:snap_bounty/model/player.dart';
import 'package:snap_bounty/view/challenge_view.dart';
import 'package:snap_bounty/provider/firestore_provider.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/view/primary_view.dart';

class ChallengeList extends StatefulWidget {
  @override
  _ChallengeListState createState() => _ChallengeListState();
}

class _ChallengeListState extends State<ChallengeList> {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  final AuthProvider _authProvider = AuthProvider();
  List<String> _completedChallenges;
  String filter;

  @override
  void initState() {
    super.initState();
    setCompletedChallenges();
  }

  void setCompletedChallenges() async {
    String playerId = await _authProvider.getUserId();
    Player player = await _firestoreProvider.getPlayer(playerId);
    setState(() {
      _completedChallenges = player.completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  StreamBuilder _buildList(BuildContext context) {
    final FirestoreProvider _firestoreProvider = FirestoreProvider();
    final PrimaryInheritedWidget _primaryInheritedWidget = PrimaryInheritedWidget.of(context);
    String filter = _primaryInheritedWidget?.data?.filter;
    print(filter);
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
    bool completed = _completedChallenges != null &&
        _completedChallenges.contains(challenge.id);
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
