import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:snap_bounty/provider/firestore_provider.dart';
import 'package:snap_bounty/view/auth_view.dart';

enum Provider { GOOGLE, FACEBOOK }
Provider identityProvider;

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirestoreProvider _firestoreProvider = FirestoreProvider();

  Stream<FirebaseUser> getAuthStateStream() {
    return _auth.onAuthStateChanged;
  }

  Future<FirebaseUser> getCurrentUser() {
    return _auth.currentUser();
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser == null)
      return Future.error(
          PlatformException(code: 'useless', message: 'Sign in cancelled.'));
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    identityProvider = Provider.GOOGLE;
    await firebaseSignIn(context, credential);
  }

  Future<void> handleFacebookSignIn(BuildContext context) async {
    final FacebookLoginResult result =
        await _facebookLogin.logInWithReadPermissions(['email']);
    if (result.status == FacebookLoginStatus.cancelledByUser)
      return Future.error(
          PlatformException(code: 'useless', message: 'Sign in cancelled.'));
    else if (result.status == FacebookLoginStatus.error)
      return Future.error(
          PlatformException(code: 'useless', message: result.errorMessage));
    else if (result.status == FacebookLoginStatus.loggedIn) {
      final FacebookAccessToken accessToken = result.accessToken;
      final AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: accessToken.token);
      identityProvider = Provider.FACEBOOK;
      return await firebaseSignIn(context, credential);
    }
  }

  Future<void> firebaseSignIn(
      BuildContext context, AuthCredential credential) async {
    try {
      final FirebaseUser user = await _auth.signInWithCredential(credential);
      _firestoreProvider.createPlayer(user.uid, user.email);
    } on PlatformException catch (error, stackTrace) {
      return Future.error(error, stackTrace);
    }
  }

  void signOut(BuildContext context) {
    if (identityProvider == Provider.GOOGLE) {
      _googleSignIn.signOut();
    } else if (identityProvider == Provider.FACEBOOK) {
      _facebookLogin.logOut();
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthPage()));
  }

  Future<String> getUserId() async {
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

  Future<String> getUserPhotoUrl() async {
    FirebaseUser user = await _auth.currentUser();
    return user.photoUrl;
  }
}
