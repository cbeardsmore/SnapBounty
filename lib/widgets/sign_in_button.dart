import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final String image;
  final Color color;
  final double yAlignment;
  final VoidCallback onPressed;

  SignInButton({this.text, this.textColor, this.image, this.color, this.yAlignment, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.07;
    final double width = MediaQuery.of(context).size.width * 0.55;

    return Align(
      alignment: AlignmentDirectional(0, yAlignment),
      child: RaisedButton(
        onPressed: onPressed ?? null,
        color: color,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Image.asset(
                  image,
                  width: 30.0,
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
