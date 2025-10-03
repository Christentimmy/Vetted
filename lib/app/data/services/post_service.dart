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
    String? personName,
    List<int>? ageRange,
    String? personLocation,
    String? sort,
    bool? onlyGreen,
    bool? onlyRed,
  }) async {
    try {
      final queryParams = <String, String>{"page": currentPage.toString()};

      if (type != null && type.isNotEmpty) {
        queryParams["type"] = type;
      }
      if (personName != null && personName.isNotEmpty) {
        queryParams["personName"] = personName;
      }
      if (ageRange != null && ageRange.isNotEmpty) {
        // Convert list to comma-separated string: e.g. "18,25"
        queryParams["ageRange"] = ageRange.join(",");
      }
      if (personLocation != null && personLocation.isNotEmpty) {
        queryParams["personLocation"] = personLocation;
      }
      if (sort != null && sort.isNotEmpty) {
        queryParams["sort"] = sort;
      }
      if (onlyGreen != null) {
        queryParams["onlyGreen"] = onlyGreen.toString(); // "true" or "false"
      }
      if (onlyRed != null) {
        queryParams["onlyRed"] = onlyRed.toString(); // "true" or "false"
      }

      final uri = Uri.parse(
        "$baseUrl/post/feed",
      ).replace(queryParameters: queryParams);

      final response = await http
          .get(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 40));

      return response;
    } on SocketException catch (e) {
      debugPrint("❌ No internet connection $e");
    } on TimeoutException {
      debugPrint("❌ Request timeout");
    } catch (e) {
      debugPrint("❌ Error: $e");
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

  Future<http.Response?> toggleSavePost({
    required String token,
    required String postId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/toggle-save-post");
      var response = await http
          .post(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"postId": postId}),
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

  Future<http.Response?> reactToPost({
    required String token,
    required String postId,
    required String emoji,
    required String reactedEmoji,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/react-to-post");
      var response = await http
          .patch(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "postId": postId,
              "emoji": emoji,
              "reactionType": reactedEmoji,
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

  Future<http.Response?> deletePostReaction({
    required String token,
    required String postId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/delete-post-reaction");
      var response = await http
          .patch(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"postId": postId}),
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

  Future<http.Response?> commentOnPost({
    required String token,
    required String postId,
    required String comment,
    required String clientId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/comment-on-post");
      var response = await http
          .post(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "postId": postId,
              "text": comment,
              "clientId": clientId,
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

  Future<http.Response?> reactToComment({
    required String token,
    required String postId,
    required String commentId,
    required String emoji,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/react-to-comment");
      var response = await http
          .post(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "postId": postId,
              "emoji": emoji,
              "reactionType": "love",
              "commentId": commentId,
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

  Future<http.Response?> getAllCommentReplies({
    required String token,
    required String parentId,
    required int currentPage,
  }) async {
    try {
      var uri = Uri.parse(
        "$baseUrl/post/get-all-comment-replies?parentId=$parentId&page=${currentPage.toString()}",
      );
      var response = await http
          .get(
            uri,
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

  Future<http.Response?> getPostComments({
    required String token,
    required String postId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/get-all-comments?postId=$postId");
      var response = await http
          .get(
            uri,
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

  Future<http.Response?> deleteComment({
    required String token,
    required String commentId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/delete-comment");
      var response = await http
          .delete(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"commentId": commentId}),
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

  Future<http.Response?> replyComment({
    required String token,
    required String commentId,
    required String comment,
    required String clientId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/reply-to-comment");
      var response = await http
          .post(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "commentId": commentId,
              "text": comment,
              "clientId": clientId,
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

  Future<http.Response?> deletePost({
    required String token,
    required String postId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/delete-post");
      var response = await http
          .delete(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"postId": postId}),
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

  Future<http.Response?> viewPosts({
    required String token,
    required List<String> postId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/view-posts");
      var response = await http
          .post(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"postIds": postId}),
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

  Future<http.Response?> voteOnPoll({
    required String token,
    required String postId,
    required String optionId,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/post/vote-on-poll");
      var response = await http
          .post(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"postId": postId, "optionId": optionId}),
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

  Future<http.Response?> getSavedPosts({required String token}) async {
    try {
      var uri = Uri.parse("$baseUrl/post/get-saved-posts");
      var response = await http
          .get(
            uri,
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
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
}
