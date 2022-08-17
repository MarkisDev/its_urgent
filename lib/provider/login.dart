import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGoogleSignedIn', true);
    notifyListeners();
  }

  Future googleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isGoogleSignedIn', false);

    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future phoneLogin(String name, String email, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPhoneSignedIn', true);

    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
  }

  Future phoneLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPhoneSignedIn', false);
  }
}
