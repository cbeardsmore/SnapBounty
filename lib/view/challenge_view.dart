import 'package:flutter/material.dart';
import 'package:snap_hero/model/challenge.dart';
import 'package:snap_hero/widgets/gradient_app_bar.dart';
import 'package:snap_hero/provider/camera_provider.dart';

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
      body: Container(child: _buildBody(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.2,
        child: FloatingActionButton(
          onPressed: () => _cameraProvider.getImage(context, challenge),
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo, size: 70),
        ),
      ),
    );
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
    return SizedBox(
      width: 300,
      child: new Card(
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: new CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Image.network(
                    challenge.icon,
                    height: 60,
                  )),
            ),
            new ListTile(
              leading: new CircleAvatar(
                child: new Icon(Icons.local_offer),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Theme.of(context).iconTheme.color,
              ),
              title:
                  new Text(challenge.category, style: TextStyle(fontSize: 20)),
              trailing: new Text('Category', style: TextStyle(fontSize: 10)),
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
              trailing: new Text('XP', style: TextStyle(fontSize: 10)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabelsBox(BuildContext context) {
    return SizedBox(
      width: 300,
      child: new Card(
        color: Theme.of(context).cardColor,
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
      labelsBox.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: ListTile(
          title: new Text(
            capitalize(k),
            style: TextStyle(fontSize: 20),
          ),
          trailing: new Text(v.toString(), style: TextStyle(fontSize: 20)),
        ),
      ));
      labelsBox.add(new Divider(
        height: 5.0,
      ));
    });
    labelsBox.removeLast();
    return labelsBox;
  }
}
