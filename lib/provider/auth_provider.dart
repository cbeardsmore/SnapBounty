import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:snap_bounty/provider/firestore_provider.dart';
import 'package:snap_bounty/view/listing_view.dart';

enum Provider { GOOGLE, FACEBOOK }
Provider identityProvider;

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirestoreProvider _firestoreProvider = FirestoreProvider();

  Future<void> handleGoogleSignIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
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
    if (result.status == FacebookLoginStatus.loggedIn) {
      final FacebookAccessToken accessToken = result.accessToken;
      final AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: accessToken.token);
      identityProvider = Provider.FACEBOOK;
      await firebaseSignIn(context, credential);
    }
    return null;
  }

  Future<void> firebaseSignIn(
      BuildContext context, AuthCredential credential) async {
    await _auth.signInWithCredential(credential);
    final FirebaseUser user = await _auth.currentUser();
    print(user.email + " ---- " + user.uid);
    _firestoreProvider.createPlayer(user.uid, user.email);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => PrimaryPage(user: user)));
  }

  void signOut(BuildContext context) {
    if (identityProvider == Provider.GOOGLE) {
      _googleSignIn.signOut();
    } else if (identityProvider == Provider.FACEBOOK) {
      _facebookLogin.logOut();
    }
    print(identityProvider.toString());
    Navigator.pushReplacementNamed(context, '/auth');
  }

  Future<String> getUserId() async {
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

  Future<String> getUserPhotoUrl() async {
    FirebaseUser user = await _auth.currentUser();
    print(user);
    print(user.photoUrl);
    return user.photoUrl;
  }
}
