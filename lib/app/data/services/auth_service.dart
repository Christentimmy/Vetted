import 'dart:convert';
import 'package:Vetted/app/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  http.Client client = http.Client();
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> _initializeSignIn() async {
    final clientId =
        "423296603409-hsm4l97oob8tdkrtk2avn77cal1d7cm3.apps.googleusercontent.com";
    final serverClientId =
        "423296603409-lechplsgug2dtpsa9r6hrkptihsl6tdn.apps.googleusercontent.com";

    await _googleSignIn.initialize(
      clientId: clientId,
      serverClientId: serverClientId,
    );
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      await _initializeSignIn();
      final googleUser = await _googleSignIn.authenticate();
      return googleUser;
    } catch (e) {
      debugPrint("Google Sign-In error: $e");
    }
    return null;
  }

  Future<http.Response?> sendGoogleToken({
    required String token,
    required bool isRegister,
  }) async {
    try {
      final authUrl =
          isRegister
              ? "$baseUrl/auth/google-sign-up"
              : "$baseUrl/auth/google-login";
      final response = await http.post(
        Uri.parse(authUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"token": token}),
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.disconnect();
  }

}
