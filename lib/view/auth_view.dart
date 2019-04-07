import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _buildBackground(),
      _buildLogo(context),
      _buildLoginButton(context),
    ]);
  }

  Container _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/entry.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Align _buildLogo(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, -0.75),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.80,
          decoration: new BoxDecoration(
              border: new Border.all(
                  color: Theme.of(context).primaryColor, width: 5.0),
              borderRadius:
                  new BorderRadius.only(topLeft: new Radius.circular(50.0))),
          child: Center(
            child: Text(
              'snapHero',
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 50,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }

  Align _buildLoginButton(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0, 0.8),
      child: RaisedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/primary');
        },
        color: Colors.white,
        child: Container(
          width: 230.0,
          height: 50.0,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
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
