import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Vetted/app/data/models/post_model.dart';
import 'package:Vetted/app/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class PostService {
  Future<http.Response?> createPost({
    required String token,
    PostModel? postModel,
    List<File>? files,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/create");

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token';

      if (postModel != null) {
        final json = postModel.toJson();
        json.forEach((key, value) {
          if (value != null) {
            request.fields[key] = value.toString();
          }
        });
      }

      if (postModel?.poll != null) {
        request.fields['poll'] = jsonEncode(postModel!.poll!.toJson());
      }

      if (files != null) {
        for (var file in files) {
          final mimeType =
              lookupMimeType(file.path) ?? 'application/octet-stream';
          final mimeSplit = mimeType.split('/');
          request.files.add(
            await http.MultipartFile.fromPath(
              'mediaFiles',
              file.path,
              contentType: MediaType(mimeSplit[0], mimeSplit[1]),
            ),
          );
        }
      }

      var response = await request.send().timeout(const Duration(seconds: 120));
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

  Future<http.Response?> getFeed({
    required String token,
    required int currentPage,
    String? type,
  }) async {
    try {
      var queryParams = {"page": currentPage.toString()};
      if (type != null) {
        queryParams["type"] = type;
      }
      final uri = Uri.parse(
        "$baseUrl/post/feed",
      ).replace(queryParameters: queryParams);

      var response = await http
          .get(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 120));
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

  Future<http.Response?> voteOnWoman({
    required String token,
    required String postId,
    required String color,
  }) async {
    try {
      final uri = Uri.parse("$baseUrl/post/vote-on-woman");
      final response = await http
          .post(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"postId": postId, "color": color.toLowerCase()}),
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
}
