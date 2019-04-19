import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

Provider identityProvider;
FirebaseUser user;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FacebookLogin _facebookLogin = FacebookLogin();

enum Provider { GOOGLE, FACEBOOK }

Future<void> handleGoogleSignIn(BuildContext context) async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  await firebaseSignIn(context, Provider.GOOGLE, credential);
}

Future<void> handleFacebookSignIn(BuildContext context) async {
  final FacebookLoginResult result =
      await _facebookLogin.logInWithReadPermissions(['email']);
  if (result.status == FacebookLoginStatus.loggedIn) {
    final FacebookAccessToken accessToken = result.accessToken;
    final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: accessToken.token);
    await firebaseSignIn(context, Provider.FACEBOOK, credential);
  }
  return null;
}

Future<void> firebaseSignIn(BuildContext context, Provider provider, AuthCredential credential) async {
    identityProvider = provider;
    await _auth.signInWithCredential(credential);
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.email + " ---- " + user.uid);
    Navigator.pushReplacementNamed(context, '/primary');
}

void signOut(BuildContext context) {
  Navigator.pushReplacementNamed(context, '/auth');
}
