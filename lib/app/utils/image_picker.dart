import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

Future<List<File>?> pickMultipleImages() async {
  try {
    final picker = ImagePicker();
    List<XFile> pickedFiles = await picker.pickMultiImage(limit: 10);
    print(pickedFiles);
    if (pickedFiles.isEmpty) return null;
    List<File> files = [];
    for (var file in pickedFiles) {
      files.add(File(file.path));
    }
    return files;
  } catch (e) {
    print('Error picking multiple images: $e');
    return null;
  }
}

pickImage() async {
  try {
    //ImageQuality: 50
    final picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedFile == null) return null;
    return File(pickedFile.path);
  } catch (e) {
    return null;
  }
}

Future<File?> pickVideo() async {
  final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

  if (pickedFile != null) {
    final compressedVideo = await VideoCompress.compressVideo(
      pickedFile.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );

    return compressedVideo?.file;
  }

  return null;
}

Future<List<File>?> pickNoCompressedImages() async {
  try {
    final picker = ImagePicker();
    List<XFile> pickedFiles = await picker.pickMultiImage(
      limit: 5,
      imageQuality: 40,
    );

    if (pickedFiles.isNotEmpty) {
      List<File> files = [];

      for (var file in pickedFiles) {
        files.add(File(file.path));
      }

      return files;
    }
    return null;
  } catch (e) {
    debugPrint('Error picking multiple images: $e');
    return null;
  }
}
