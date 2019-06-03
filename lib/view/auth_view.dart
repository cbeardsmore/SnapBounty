import 'package:flutter/material.dart';
import 'package:snap_bounty/widgets/sign_in_button.dart';
import 'package:snap_bounty/provider/auth_provider.dart';
import 'package:snap_bounty/app_state.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    double progressIndicatorSize = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
      body: Stack(children: <Widget>[
        _buildBackground(),
        _buildLogo(context),
        _buildGoogleLoginButton(context),
        _buildFacebookLoginButton(context),
        _loading
            ? Align(
                child: SizedBox(
                    height: progressIndicatorSize,
                    width: progressIndicatorSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,

                      backgroundColor: Theme.of(context).primaryColor,
                    )))
            : SizedBox.shrink()
      ]),
    );
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
    final double height = MediaQuery.of(context).size.height * 0.14;
    final double width = MediaQuery.of(context).size.width * 0.80;

    return Align(
      alignment: AlignmentDirectional(0, -0.78),
      child: Container(
        height: height,
        width: width,
        decoration: new BoxDecoration(
            border: new Border.all(
                color: Theme.of(context).primaryColor, width: 5.0),
            borderRadius:
                new BorderRadius.only(topLeft: new Radius.circular(50.0))),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'SnapBounty',
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 50,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleLoginButton(BuildContext context) {
    final AuthProvider _authProvider = AuthProvider();

    return SignInButton(
        text: 'Sign in with Google',
        image: 'assets/google_logo.png',
        color: Colors.white,
        yAlignment: 0.65,
        onPressed: () =>
            onPressedWrapper(context, _authProvider.handleGoogleSignIn));
  }

  Widget _buildFacebookLoginButton(BuildContext context) {
    final AuthProvider _authProvider = AuthProvider();
    return SignInButton(
        text: 'Continue with Facebook',
        textColor: Colors.white,
        image: 'assets/facebook_logo.png',
        color: Color(0xFF4267B2),
        yAlignment: 0.83,
        onPressed: () =>
            onPressedWrapper(context, _authProvider.handleFacebookSignIn));
  }

  void onPressedWrapper(BuildContext context, Function signIn) {
    setState(() {
      _loading = true;
    });
    signIn(context)
        .then((value) => Navigator.push(
            context, MaterialPageRoute(builder: (context) => PrimaryApp())))
        .catchError((error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Please Try Again'),
              content: Text(error.message),
              actions: <Widget>[
                FlatButton(
                  child: Text('CONTINUE',
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 18)),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            );
          });
    });
    setState(() {
      _loading = false;
    });
  }
}
