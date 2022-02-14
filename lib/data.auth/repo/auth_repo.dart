import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp/data.auth/listeners/auth_login_listener.dart';
import 'package:shopapp/data.auth/listeners/auth_registration_listener.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("uid");
      print("uid removed");
    } catch (e) {
      print("Sign out went wrong $e");
    }
  }

  Future<void> loginUserWithGoogle(
      {required AuthLoginListener authLoginListener}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        String currentUserId;

        user = userCredential.user;
        currentUserId = user!.uid;
        authLoginListener.success(currentUserId);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          authLoginListener.failed("account exist different credentials");
        } else if (e.code == 'invalid-credential') {
          authLoginListener.failed(e.code);
        }
      } catch (e) {
        authLoginListener.failed("error");
      }
    }
  }

  void loginUser(
      {required String email,
      required String password,
      required AuthLoginListener authLoginListener}) async {
    String currentUserId;
    var authInstance = FirebaseAuth.instance;
    try {
      var authResult = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      if (authResult.user != null) {
        currentUserId = authResult.user!.uid;
        authLoginListener.success(currentUserId);
      }
    } catch (e) {
      authLoginListener.failed("error");
    }
  }

  void registerUser(
      {required String email,
      required String password,
      required AuthRegistrationListener authRegistrationListener}) async {
    var authInstance = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await authInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user?.sendEmailVerification();
      authInstance.signOut();
      authRegistrationListener.success();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        authRegistrationListener.weakPassword();
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        authRegistrationListener.userExists();
      }
    } catch (e) {
      print(e);
      authRegistrationListener.failed();
    }
  }
}
