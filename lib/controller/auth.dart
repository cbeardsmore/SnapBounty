import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

Provider identityProvider;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FacebookLogin _facebookLogin = FacebookLogin();

enum Provider { GOOGLE, FACEBOOK }

Future<FirebaseUser> handleGoogleSignIn(BuildContext context) async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);
  identityProvider = Provider.GOOGLE;
  Navigator.pushReplacementNamed(context, '/primary');
  return user;
}

Future<void> handleFacebookSignIn(BuildContext context) async {
  final FacebookLoginResult result =
      await _facebookLogin.logInWithReadPermissions(['email']);
  if (result.status == FacebookLoginStatus.loggedIn) {
    identityProvider = Provider.FACEBOOK;
    Navigator.pushReplacementNamed(context, '/primary');
  }
}

void signOut(BuildContext context) {
  if (identityProvider == Provider.GOOGLE) {
    _googleSignIn.signOut();
  } else if (identityProvider == Provider.FACEBOOK) {
    _facebookLogin.logOut();
  }
  Navigator.pushReplacementNamed(context, '/auth');
}
