import 'package:Vetted/app/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubscriptionService {
  Future<http.Response?> createSubscription({required String token}) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/subscription/create"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> cancelSubscription({required String token}) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/subscription/cancel"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }


  Future<http.Response?> resumeSubscription({required String token}) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/subscription/reactivate"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

}
