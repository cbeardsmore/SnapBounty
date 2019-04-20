import 'package:flutter/material.dart';
import 'dart:io';
import 'package:snap_hero/widgets/gradient_app_bar.dart';
import 'package:snap_hero/model/challenge.dart';
import 'package:snap_hero/provider/vision_provider.dart';

String passIconUrl =
    'https://firebasestorage.googleapis.com/v0/b/snap-hero-1.appspot.com/o/icons-face%2Fsmile.png?alt=media&token=55141f74-d1c8-418e-9fc6-6e36a753c8d1';
String failIconUrl =
    'https://firebasestorage.googleapis.com/v0/b/snap-hero-1.appspot.com/o/icons-face%2Fcry.png?alt=media&token=16105dfd-a776-4dde-8e59-bdaa9c111ed7';
String neutralIconUrl =
    'https://firebasestorage.googleapis.com/v0/b/snap-hero-1.appspot.com/o/icons-face%2Fneutral.png?alt=media&token=88dbac4d-2231-4f7a-86f2-05d03056cf34';

class SnapPage extends StatelessWidget {
  final File image;
  final Challenge challenge;

  SnapPage(this.image, this.challenge);

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppBar(challenge.name),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: ClipRRect(
                borderRadius: new BorderRadius.circular(12.0),
                child: Image.file(image)),
          ),
          _buildLabelsBox(context),
        ],
      ),
    );
  }

  Widget _buildLabelsBox(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 10,
          color: Theme.of(context).cardColor, child: _buildLabelsList(context)),
    );
  }

  Widget _buildLabelsList(BuildContext context) {
    final VisionProvider _visionProvider = VisionProvider();
    return FutureBuilder(
        future: _visionProvider.getLabels(image),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, double>> snapshot) {
          List<Widget> labelsBox = List();
          labelsBox.add(Text('Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
          challenge.labels.forEach((k, v) {
            String actualConfidence = '0.0';
            Widget actualLeading = CircleAvatar(
                backgroundColor: Colors.yellow,
                foregroundColor: Theme.of(context).iconTheme.color,
                child: Image.network(
                  neutralIconUrl,
                  height: 30,
                ));
            if (snapshot.hasData) {
              if (snapshot.data[k] != null && snapshot.data[k] >= v) {
                actualConfidence = snapshot.data[k].toStringAsFixed(1);
                actualLeading = CircleAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                    foregroundColor: Theme.of(context).iconTheme.color,
                    child: Image.network(
                      passIconUrl,
                      height: 30,
                    ));
              } else {
                actualLeading = CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Theme.of(context).iconTheme.color,
                    child: Image.network(
                      failIconUrl,
                      height: 30,
                    ));
              }
            }
            labelsBox.add(Divider(
              height: 5.0,
            ));
            labelsBox.add(ListTile(
              leading: actualLeading,
              title: Text(
                capitalize(k),
                style: TextStyle(fontSize: 20),
              ),
              trailing: Text(actualConfidence + '/' + v.toString(),
                  style: TextStyle(fontSize: 18)),
            ));
          });
          labelsBox.add(Text(snapshot.data.toString()));
          return Column(
            children: labelsBox,
          );
        });
  }
}