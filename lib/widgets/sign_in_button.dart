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
    final double width = MediaQuery.of(context).size.width * 0.6;
    final double imageSize = MediaQuery.of(context).size.width * 0.07;

    return Align(
      alignment: AlignmentDirectional(0, yAlignment),
      child: RaisedButton(
        onPressed: onPressed ?? null,
        color: color,
        child: Container(
          constraints: BoxConstraints(maxWidth: 300),
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Image.asset(
                  image,
                  width: imageSize,
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
