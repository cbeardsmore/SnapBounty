import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<FirebaseUser> handleGoogleSignIn(BuildContext context) async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);
  print("signed in " + user.displayName);
  Navigator.pushReplacementNamed(context, '/primary');
  return user;
}

void handleGoogleSignOut(BuildContext context) async {
  _googleSignIn.signOut();
  Navigator.pushReplacementNamed(context, '/auth');
}

Future<void> handleFacebookSignIn(BuildContext context) async {
  print('ping');
  final FacebookLogin facebookLogin = FacebookLogin();
  print('pong');
  final FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['email']);
  print('dong');
  
  if (result.status == FacebookLoginStatus.loggedIn) {
    print("signed in via facebook");
    Navigator.pushReplacementNamed(context, '/primary');
  }
}


 