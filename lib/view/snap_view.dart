import 'dart:io';
import 'package:flutter/material.dart';

import 'package:snap_bounty/utils.dart';
import 'package:snap_bounty/controller/challenge_result_controller.dart';
import 'package:snap_bounty/model/challenge_result.dart';
import 'package:snap_bounty/model/challenge.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';

class SnapPage extends StatefulWidget {
  final File image;
  final Challenge challenge;

  SnapPage(this.image, this.challenge);

  @override
  _SnapPageState createState() => _SnapPageState();
}

class _SnapPageState extends State<SnapPage> {
  final ChallengeResultController _challengeResultController =
      ChallengeResultController();
  ChallengeResult _challengeResult;

  @override
  void initState() {
    super.initState();
    setLabels();
  }

  void setLabels() async {
    ChallengeResult updatedResult = await _challengeResultController
        .attemptChallenge(widget.image, widget.challenge);
    setState(() {
      _challengeResult = updatedResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar(widget.challenge.name),
        ),
        body: Stack(
          children: <Widget>[
            _buildBackground(context),
            _buildLabelsBox(context),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _buildFloatingActionButton(context));
  }

  Container _buildBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(widget.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildLabelsBox(BuildContext context) {
    Widget innerChild = CircularProgressIndicator();
    if (_challengeResult != null) {
      innerChild = Card(
          elevation: 10,
          color: Theme.of(context).cardColor.withOpacity(0.5),
          child: _buildLabelsList(context));
    }

    return Center(
      child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Container(
              alignment: AlignmentDirectional(0, 0.4), child: innerChild)),
    );
  }

  Widget _buildLabelsList(BuildContext context) {
    List<Widget> labelsBox = List();
    labelsBox.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Results',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    ));
    widget.challenge.labels.forEach((k, v) {
      double actualConfidence = 0.0;
      Widget actualLeading =
          _buildLeadingAvatar(context, Colors.yellow, 'assets/neutral.png');
      if (_challengeResult.labels[k] != null) {
        actualConfidence = _challengeResult.labels[k];
      }

      if (actualConfidence >= v) {
        actualLeading = _buildLeadingAvatar(
            context, Colors.lightGreenAccent[400], 'assets/smile.png');
      } else if (actualConfidence < (v - 0.1)) {
        print(_challengeResult.labels.toString());
        actualLeading =
            _buildLeadingAvatar(context, Colors.red, 'assets/cry.png');
      }

      labelsBox.add(Divider(
        height: 5.0,
      ));
      labelsBox.add(ListTile(
        leading: actualLeading,
        title: Text(
          Utils.capitalize(k),
          style: TextStyle(fontSize: 20),
        ),
        trailing: Text(
            Utils.toPercent(actualConfidence) + ' / ' + Utils.toPercent(v),
            style: TextStyle(fontSize: 18)),
      ));
    });
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: labelsBox,
    );
  }

  Widget _buildLeadingAvatar(BuildContext context, Color color, String image) {
    return CircleAvatar(
        backgroundColor: color,
        foregroundColor: Theme.of(context).iconTheme.color,
        child: Image.asset(
          image,
          height: 30,
        ));
  }

  Container _buildFloatingActionButton(BuildContext context) {
    if (_challengeResult == null) return Container();
    bool success = _challengeResult.isSuccess;
    Size mediaSize = MediaQuery.of(context).size;

    return Container(
        width: mediaSize.width * 0.2,
        height: mediaSize.height * 0.2,
        child: FloatingActionButton(
          backgroundColor: success ? Colors.lightGreenAccent[400] : Colors.red,
          foregroundColor: Theme.of(context).accentColor,
          onPressed: () => Navigator.pop(context),
          tooltip: success ? 'Challenge Completed!' : 'Try Again?',
          child: Icon(success ? Icons.check : Icons.clear, size: 50),
        ));
  }
}
