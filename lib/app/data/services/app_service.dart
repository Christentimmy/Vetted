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
      final uri = Uri.parse("$baseUrl/services/enformion-number-search");
      final response = await client
          .post(
            uri,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'number': phoneNumber}),
          )
          .timeout(const Duration(seconds: 30));
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
    required String firstName,
    required String lastName,
    String? middleName,
    String? street,
    String? stateCode,
    String? city,
    String? zipCode,
  }) async {
    final url = Uri.parse("$baseUrl/services/name-lookup");

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'name': "$firstName $lastName",
      'street': street,
      'state_code': stateCode,
      'city': city,
      'zipCode': zipCode,
    });

    try {
      final response = await client
          .post(url, headers: headers, body: body)
          .timeout(const Duration(seconds: 30));

      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection: $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("Unexpected error: $e");
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
      final response = await client
          .get(
            Uri.parse(
              "$baseUrl/services/get-sex-offenders?lat=$lat&lng=$lng&radius=$radius",
            ),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 30));
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

  Future<http.Response?> getSexOffenderByName({
    required String token,
    required String name,
  }) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/services/get-sex-offender-by-name?name=$name"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 30));
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

  Future<http.Response?> getCriminalRecord({
    required String token,
    required String firstName,
    required String lastName,
    String? middleName,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/services/enformion-criminal-search"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'firstName': firstName,
              'lastName': lastName,
              'middleName': middleName,
            }),
          )
          .timeout(const Duration(seconds: 30));
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
