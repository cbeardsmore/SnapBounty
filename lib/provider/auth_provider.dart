import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await firebaseSignIn(context, credential);
  }

  Future<void> handleFacebookSignIn(BuildContext context) async {
    final FacebookLoginResult result =
        await _facebookLogin.logInWithReadPermissions(['email']);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final FacebookAccessToken accessToken = result.accessToken;
      final AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: accessToken.token);
      await firebaseSignIn(context, credential);
    }
    return null;
  }

  Future<void> firebaseSignIn(
      BuildContext context, AuthCredential credential) async {
    await _auth.signInWithCredential(credential);
    final FirebaseUser user = await _auth.currentUser();
    print(user.email + " ---- " + user.uid);
    Navigator.pushReplacementNamed(context, '/primary');
  }

  void signOut(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/auth');
  }
}
