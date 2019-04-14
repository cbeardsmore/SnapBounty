import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  final String title;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final Color startColor = Theme.of(context).primaryColorLight;
    final Color endColor = Theme.of(context).accentColor;

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      decoration: gradient(startColor, endColor),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  BoxDecoration gradient(Color startColor, Color endColor) {
    return BoxDecoration(
        gradient: LinearGradient(
      colors: [startColor, endColor],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(2, 0.0),
    ));
  }
}
