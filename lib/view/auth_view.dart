import 'package:flutter/material.dart';
import 'package:snap_bounty/widgets/sign_in_button.dart';
import 'package:snap_bounty/provider/auth_provider.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider = AuthProvider();
    return Stack(children: <Widget>[
      _buildBackground(),
      _buildLogo(context),
      _buildGoogleLoginButton(context, _authProvider),
      _buildFacebookLoginButton(context, _authProvider),
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
          child: Center(
            child: Text(
              'SnapBounty',
              style: Theme.of(context).textTheme.title.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: 50,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }

  SignInButton _buildGoogleLoginButton(BuildContext context, AuthProvider _authProvider) {
    return SignInButton(
      text: 'Sign in with Google',
      image: 'assets/google_logo.png',
      color: Colors.white,
      yAlignment: 0.65,
      onPressed: () => _authProvider.handleGoogleSignIn(context),
    );
  }

  SignInButton _buildFacebookLoginButton(BuildContext context, AuthProvider _authProvider) {
    return SignInButton(
      text: 'Continue with Facebook',
      textColor: Colors.white,
      image: 'assets/facebook_logo.png',
      color: Color(0xFF4267B2),
      yAlignment: 0.83,
      onPressed: () => _authProvider.handleFacebookSignIn(context),
    );
  }
}
