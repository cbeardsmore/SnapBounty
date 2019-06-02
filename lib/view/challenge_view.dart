import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:snap_bounty/model/challenge.dart';
import 'package:snap_bounty/provider/camera_provider.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';

class ChallengePage extends StatelessWidget {
  final Challenge challenge;

  ChallengePage(this.challenge);

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final CameraProvider _cameraProvider = CameraProvider();

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar(challenge.name),
        ),
        body: Stack(children: <Widget>[
          _buildBackground(),
          _buildBody(context),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
            _buildFloatingActionButton(context, _cameraProvider));
  }

  Container _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(challenge.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Container _buildFloatingActionButton(
      BuildContext context, CameraProvider cameraProvider) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.2,
        child: FloatingActionButton(
          onPressed: () => cameraProvider.getImage(context, challenge),
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo, size: 70),
        ));
  }

  Widget _buildBody(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: mediaSize.height * 0.05,
          width: mediaSize.width,
        ),
        _buildDetailsBox(context),
        SizedBox(
          height: mediaSize.height * 0.02,
        ),
        _buildLabelsBox(context),
      ],
    );
  }

  Widget _buildDetailsBox(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.local_offer),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).iconTheme.color,
              ),
              title:
                  Text(challenge.category, style: TextStyle(fontSize: 20)),
              trailing: Text('Category', style: TextStyle(fontSize: 12)),
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.star),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).iconTheme.color,
              ),
              title: Text(challenge.xp.toString(),
                  style: TextStyle(fontSize: 20)),
              trailing: Text('XP', style: TextStyle(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabelsBox(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        child: Column(children: _buildLabelsList(context)),
      ),
    );
  }

  List<Widget> _buildLabelsList(BuildContext context) {
    List<Widget> labelsBox = List();
    labelsBox.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Required',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ));
    challenge.labels.forEach((k, v) {
      labelsBox.add(
        ListTile(
          contentPadding: EdgeInsets.only(left: 20, right: 20),
          title: Text(
            capitalize(k),textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          trailing: Text(v.toString(), style: TextStyle(fontSize: 20)),
        ),
      );
      labelsBox.add(Divider(
        height: 5.0,
      ));
    });
    labelsBox.removeLast();
    return labelsBox;
  }
}
