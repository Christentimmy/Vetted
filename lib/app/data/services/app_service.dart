import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AppService {
  final http.Client client = http.Client();

  Future<http.Response?> imageSearch({
    required File file,
    required String token,
  }) async {
    try {
      final uri = Uri.parse("$baseUrl/services/google-image-search");
      final request = http.MultipartRequest('POST', uri);
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
      request.headers['Authorization'] = 'Bearer $token';

      final response = await request.send();
      return await http.Response.fromStream(response);
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getNumberInfo({
    required String phoneNumber,
    required String token,
  }) async {
    try {
      final uri = Uri.parse(
        "$baseUrl/services/phone-lookup?phone=$phoneNumber",
      );
      final response = await client.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
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

  Future<http.Response?> backgroundCheck({
    required String token,
    required String name,
    required String street,
    required String stateCode,
    required String city,
    required String zipCode,
  }) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/services/name-lookup"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'street': street,
          'stateCode': stateCode,
          'city': city,
          'zipCode': zipCode,
        }),
      );
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

  Future<http.Response?> getOffendersMap({
    required String token,
    required double lat,
    required double lng,
    required double radius,
  }) async {
    try {
      final response = await client.get(
        Uri.parse(
          "$baseUrl/services/get-sex-offenders?lat=$lat&lng=$lng&radius=$radius",
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
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
}
