import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snap_hero/model/challenge.dart';

class ChallengeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  StreamBuilder _buildList(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('challenges').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: const CircularProgressIndicator());
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                Challenge challenge =
                    Challenge.fromDocument(snapshot.data.documents[index]);
                return _buildListItem(context, challenge);
              });
        });
  }

  Card _buildListItem(BuildContext context, Challenge challenge) {
    Color baseColor = Theme.of(context).primaryColor;
          return Card(
            color: Theme.of(context).cardColor,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                  leading: CircleAvatar(
                      radius: 26,
                      backgroundColor: baseColor,
                      child: Image.network(
                        challenge.icon,
                        height: 40,
                      )),
                  title: Text(challenge.name, style: TextStyle(fontSize: 22))),
            ),
          );
        
  }
}
