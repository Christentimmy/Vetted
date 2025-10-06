import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/data/models/user_model.dart';
import 'package:Vetted/app/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UserService {
  final http.Client client = http.Client();

  Future<http.Response?> updateName({
    required String token,
    required String name,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/user/update-name");
      final response = await client
          .post(
            url,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"name": name}),
          )
          .timeout(const Duration(seconds: 60));
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

  Future<http.Response?> updateDob({
    required String token,
    required DateTime dateOfBirth,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/user/update-dob");
      final response = await client
          .post(
            url,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"dateOfBirth": dateOfBirth.toUtc().toString()}),
          )
          .timeout(const Duration(seconds: 60));
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

  Future<http.Response?> updateLocation({
    required String token,
    required LocationModel location,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/user/update-location");
      final response = await client
          .post(
            url,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "address": location.address,
              "lat": location.coordinates?.first,
              "lng": location.coordinates?.last,
            }),
          )
          .timeout(const Duration(seconds: 60));
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

  Future<http.Response?> updateRelationStatus({
    required String token,
    required String relationStatus,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/user/update-relation-status");
      final response = await client
          .patch(
            url,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"relationStatus": relationStatus}),
          )
          .timeout(const Duration(seconds: 60));
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

  Future<http.Response?> getUserDetails({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-user-details"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 15));
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

  Future<http.Response?> userExist({required String email}) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/user-exist"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email}),
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

  Future<http.Response?> verifyGender({
    required File videoFile,
    required String token,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/user/verify-gender');
      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      // Attach video file
      request.files.add(
        await http.MultipartFile.fromPath(
          'media',
          videoFile.path,
          contentType: MediaType('video', 'mp4'),
        ),
      );

      // Send request
      final streamedResponse = await request.send();

      // Convert to regular Response
      final response = await http.Response.fromStream(streamedResponse);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getUserStatus({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-user-status"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 3));
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

  Future<http.Response?> saveUserOneSignalId({
    required String token,
    required String id,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/save-signal-id"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"pushId": id}),
          )
          .timeout(const Duration(seconds: 15));
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

  Future<http.Response?> reportUser({
    required String token,
    required String type,
    required String reason,
    required String reportedUser,
    required String referenceId,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/user/create-report");
      final response = await http
          .post(
            url,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "type": type.toLowerCase(),
              "description": reason,
              "reportedUser": reportedUser,
              "referenceId": referenceId,
            }),
          )
          .timeout(const Duration(seconds: 60));
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

  Future<http.Response?> toggleBlock({
    required String token,
    required String blockId,
  }) async {
    try {
      final response = await client
          .patch(
            Uri.parse("$baseUrl/user/toggle-block"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"blockId": blockId}),
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

  Future<http.Response?> toggleFollow({
    required String token,
    required String userId,
  }) async {
    try {
      final response = await client
          .patch(
            Uri.parse("$baseUrl/user/toggle-follow"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"followId": userId}),
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

  Future<http.Response?> getNotification({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-notifications"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 60));
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

  Future<http.Response?> markNotificationAsRead({
    required String token,
    required String id,
  }) async {
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/user/mark-notification-as-read"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"notificationId": id}),
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

  Future<http.Response?> editProfile({
    required String token,
    required UserModel userModel,
  }) async {
    try {
      final response = await client.patch(
        Uri.parse("$baseUrl/user/edit-profile"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "displayName": userModel.displayName,
          "phone": userModel.phone,
          "email": userModel.email,
          "location": {
            "address": userModel.location?.address,
            "lng": userModel.location?.coordinates?[0],
            "lat": userModel.location?.coordinates?[1],
          },
        }),
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getAllUserPost({
    required String token,
    required String userId,
    required int currentPage,
  }) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-my-posts").replace(
              queryParameters: {
                "userId": userId,
                "pageNum": currentPage.toString(),
              },
            ),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 60));
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

  Future<http.Response?> createAlert({
    required String token,
    required String name,
  }) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/user/create-alert"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"name": name}),
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> createTicket({
    required String token,
    required List<File> attachments,
    required String subject,
    required String description,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/support-ticket/create-ticket");
      final requests = http.MultipartRequest("POST", url)
        ..headers['Authorization'] = 'Bearer $token';
      final files = await Future.wait(
        attachments
            .map((e) => http.MultipartFile.fromPath('attachments', e.path))
            .toList(),
      );
      requests.files.addAll(files);
      requests.fields['subject'] = subject;
      requests.fields['description'] = description;
      final response = await requests.send().timeout(
        const Duration(seconds: 60),
      );
      return await http.Response.fromStream(response);
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getAlert({required String token}) async {
    try {
      final response = await client.get(
        Uri.parse("$baseUrl/user/get-alerts"),
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

  Future<http.Response?> deleteAlert({
    required String token,
    required String id,
  }) async {
    try {
      final response = await client
          .delete(
            Uri.parse("$baseUrl/user/delete-alert/$id"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> changeNotificationSetting({
    required String token,
    required bool general,
    required bool trendingPost,
    required bool newComments,
    required bool alertForWomenNames,
    required bool reactions,
  }) async {
    try {
      final response = await client.post(
        Uri.parse("$baseUrl/user/change-notification-settings"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "general": general,
          "trendingPost": trendingPost,
          "newComments": newComments,
          "alertForWomenNames": alertForWomenNames,
          "reactions": reactions,
        }),
      );
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

}
