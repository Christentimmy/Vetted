import 'dart:io';
import 'package:image_picker/image_picker.dart';

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


