import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final Color startColor = Color(0xFFFFFC00);
  final Color endColor = Color(0xFFFF6600);

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      decoration: gradient(),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            fontStyle: FontStyle.italic,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  BoxDecoration gradient() {
    return BoxDecoration(
        gradient: LinearGradient(
      colors: [startColor, endColor],
      begin: const FractionalOffset(0.0, 0.0),
      end: const FractionalOffset(2, 0.0),
    ));
  }
}
