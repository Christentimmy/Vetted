import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/utils/base_url.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  http.Client client = http.Client();
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<http.Response?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/auth/login"),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 20));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<void> _initializeSignIn() async {
    final serverClientId =
        "339208855443-0p22l7s1scbv7afbrfi66ajb0p08di5v.apps.googleusercontent.com";
    final clientId =
        "339208855443-p2mkvu4k3nfgnghvb2q1lv1kjhaqhefb.apps.googleusercontent.com";
    final iosClientId =
        "339208855443-1i11hrdqnlanasjmhko1tel2ift9s75q.apps.googleusercontent.com";

    await _googleSignIn.initialize(
      clientId: Platform.isAndroid ? clientId : iosClientId,
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

  Future<http.Response?> logout({required String token}) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/auth/logout"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 20));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> registerWithNumber({
    required String phoneNumber,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/auth/register-with-phoneNumber"),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"phone": phoneNumber}),
          )
          .timeout(const Duration(seconds: 20));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> loginWithNumber({required String phoneNumber}) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/auth/login-with-phoneNumber"),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"phone": phoneNumber}),
          )
          .timeout(const Duration(seconds: 20));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> sendNumberOtp({required String phoneNumber}) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/auth/send-number-otp"),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"phone": phoneNumber}),
          )
          .timeout(const Duration(seconds: 20));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> verifyNumberOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/auth/verify-number-otp"),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"phone": phoneNumber, "otp": otp}),
          )
          .timeout(const Duration(seconds: 20));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> register({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/register'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException {
      CustomSnackbar.showErrorToast("No internet connection");
    } on TimeoutException {
      CustomSnackbar.showErrorToast("Request timeout, please try again");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/verify-otp'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "otp": otp}),
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException {
      CustomSnackbar.showErrorToast("No internet connection");
    } on TimeoutException {
      CustomSnackbar.showErrorToast("Request timeout, please try again");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> sendOtp({required String email}) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/send-otp'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email}),
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException {
      CustomSnackbar.showErrorToast("No internet connection");
    } on TimeoutException {
      CustomSnackbar.showErrorToast("Request timeout, please try again");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> resetPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/auth/reset-password'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email, "password": password}),
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException {
      CustomSnackbar.showErrorToast("No internet connection");
    } on TimeoutException {
      CustomSnackbar.showErrorToast("Request timeout, please try again");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
