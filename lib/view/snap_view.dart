import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snap_hero/widgets/gradient_app_bar.dart';
import 'package:snap_hero/model/challenge.dart';
import 'package:snap_hero/provider/vision_provider.dart';

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
        body: Stack(
          children: <Widget>[
            _buildBackground(context),
            _buildLabelsBox(context)
          ],
        ));
  }

  Container _buildBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLabelsBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Container(
        alignment: AlignmentDirectional(0, 0.6),
            child: Card(
                elevation: 10,
                color: Theme.of(context).cardColor.withOpacity(0.5),
                child: _buildLabelsList(context)),
          ),
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
                child: Image.asset(
                  'assets/neutral.png',
                  height: 30,
                ));
            if (snapshot.hasData) {
              if (snapshot.data[k] != null && snapshot.data[k] >= v) {
                actualConfidence = snapshot.data[k].toStringAsFixed(1);
                actualLeading = CircleAvatar(
                    backgroundColor: Colors.lightGreenAccent,
                    foregroundColor: Theme.of(context).iconTheme.color,
                    child: Image.asset(
                      'assets/smile.png',
                      height: 30,
                    ));
              } else {
                actualLeading = CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Theme.of(context).iconTheme.color,
                    child: Image.asset(
                      'assets/cry.png',
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
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: labelsBox,
          );
        });
  }
}
