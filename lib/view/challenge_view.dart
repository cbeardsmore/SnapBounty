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
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
        ),
        _buildDetailsBox(context),
        SizedBox(
          height: 20,
        ),
        _buildLabelsBox(context),
      ],
    );
  }

  Widget _buildDetailsBox(BuildContext context) {
    return Container(
      width: 280,
      child: new Card(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(Icons.local_offer),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).iconTheme.color,
              ),
              title:
                  new Text(challenge.category, style: TextStyle(fontSize: 20)),
              trailing: new Text('Category', style: TextStyle(fontSize: 12)),
            ),
            new Divider(
              height: 5.0,
            ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(Icons.star),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).iconTheme.color,
              ),
              title: new Text(challenge.xp.toString(),
                  style: TextStyle(fontSize: 20)),
              trailing: new Text('XP', style: TextStyle(fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabelsBox(BuildContext context) {
    return SizedBox(
      width: 280,
      child: new Card(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        child: Column(children: _buildLabelsList(context)),
      ),
    );
  }

  List<Widget> _buildLabelsList(BuildContext context) {
    List<Widget> labelsBox = new List();
    labelsBox.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Text('Required',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ));
    challenge.labels.forEach((k, v) {
      labelsBox.add(
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 40),
          title: new Text(
            capitalize(k),
            style: TextStyle(fontSize: 20, ),
          ),
          trailing: new Text(v.toString(), style: TextStyle(fontSize: 20)),
        ),
      );
      labelsBox.add(new Divider(
        height: 5.0,
      ));
    });
    labelsBox.removeLast();
    return labelsBox;
  }
}
