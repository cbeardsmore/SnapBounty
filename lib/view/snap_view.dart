import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snap_hero/widgets/gradient_app_bar.dart';
import 'package:snap_hero/model/challenge.dart';
import 'package:snap_hero/model/challenge_result.dart';
import 'package:snap_hero/controller/challenge_result_controller.dart';

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

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

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
            _buildLabelsBox(context)
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Container(
        alignment: AlignmentDirectional(0, 0.5),
        child: Card(
            elevation: 10,
            color: Theme.of(context).cardColor.withOpacity(0.5),
            child: _buildLabelsList(context)),
      ),
    );
  }

  Widget _buildLabelsList(BuildContext context) {
    List<Widget> labelsBox = List();
    labelsBox.add(Text('Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
    widget.challenge.labels.forEach((k, v) {
      String actualConfidence = '0.0';
      Widget actualLeading =
          _buildLeadingAvatar(context, Colors.yellow, 'assets/neutral.png');
      if (_challengeResult != null) {
        if (_challengeResult.labels[k] != null &&
            _challengeResult.labels[k] >= v) {
          actualConfidence = _challengeResult.labels[k].toStringAsFixed(1);
          actualLeading = _buildLeadingAvatar(
              context, Colors.lightGreenAccent[400], 'assets/smile.png');
        } else {
          actualLeading =
              _buildLeadingAvatar(context, Colors.red, 'assets/cry.png');
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
    return Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.2,
        child: FloatingActionButton(
          backgroundColor: success ? Colors.lightGreenAccent[400] : Colors.red,
          foregroundColor: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushReplacementNamed(context, '/primary'),
          tooltip: success ? 'Challenge Completed!' : 'Try Again?',
          child: Icon(success ? Icons.check : Icons.clear, size: 50),
        ));
  }
}
