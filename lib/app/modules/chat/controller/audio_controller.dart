// import 'dart:io';
// import 'package:Vetted/app/widgets/snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

class AudioController extends GetxController {
  // FlutterSoundPlayer? flutterPlayer = FlutterSoundPlayer();
  // FlutterSoundRecorder? flutterRecorder = FlutterSoundRecorder();
  // RxBool isFlutterPlayerInitiated = false.obs;
  // RxBool isFlutterRecorderInitiated = false.obs;

  // final Rxn<File> selectedFile = Rxn<File>(null);
  // final RxBool isRecording = false.obs;
  // final RxBool isPlaying = false.obs;
  // final RxBool showAudioPreview = false.obs;
  // final RxBool isRecordingPaused = false.obs;

  // String? _audioFilePath;

  // @override
  // void onInit() {
  //   super.onInit();
  //   initialize();
  // }

  // Future<void> initialize() async {
  //   try {
  //     await flutterPlayer!.openPlayer();
  //     isFlutterPlayerInitiated.value = true;
      
  //     await flutterRecorder!.openRecorder();
  //     isFlutterRecorderInitiated.value = true;
  //   } catch (e) {
  //     debugPrint("Error initializing audio: $e");
  //   }
  // }

  // bool isAudioFile(String path) {
  //   return path.toLowerCase().endsWith('.aac') ||
  //       path.toLowerCase().endsWith('.mp3') ||
  //       path.toLowerCase().endsWith('.wav');
  // }

  // String? getFileType(String path) {
  //   if (isAudioFile(path)) {
  //     return "audio";
  //   }
  //   return null;
  // }

  // Future<void> startRecording() async {
  //   try {
  //     HapticFeedback.lightImpact();
  //     PermissionStatus status = await Permission.microphone.request();
  //     if (status != PermissionStatus.granted) {
  //       CustomSnackbar.showErrorToast("Permission denied");
  //       return;
  //     }

  //     // Ensure recorder is initialized
  //     if (!isFlutterRecorderInitiated.value) {
  //       await initialize();
  //     }

  //     final directory = await getApplicationDocumentsDirectory();
  //     _audioFilePath =
  //         '${directory.path}/voice_message_${DateTime.now().millisecondsSinceEpoch}.aac';

  //     await flutterRecorder!.startRecorder(
  //       toFile: _audioFilePath,
  //       codec: Codec.aacADTS,
  //     );

  //     isRecording.value = true;
  //     showAudioPreview.value = true;
  //     isRecordingPaused.value = false;
  //   } catch (e) {
  //     debugPrint("Error starting recording: $e");
  //     CustomSnackbar.showErrorToast("Failed to start recording");
  //     isRecording.value = false;
  //   }
  // }

  // Future<void> pauseRecording() async {
  //   HapticFeedback.lightImpact();
  //   try {
  //     await flutterRecorder!.pauseRecorder();
  //     isRecordingPaused.value = true;
  //   } catch (e) {
  //     debugPrint("Error pausing recording: $e");
  //     CustomSnackbar.showErrorToast("Failed to pause recording");
  //   }
  // }

  // Future<void> stopRecording() async {
  //   try {
  //     final path = await flutterRecorder!.stopRecorder();
  //     isRecording.value = false;
      
  //     if (path != null && path.isNotEmpty) {
  //       selectedFile.value = File(path);
  //       _audioFilePath = path;
  //     }
  //   } catch (e) {
  //     debugPrint("Error stopping recording: $e");
  //     CustomSnackbar.showErrorToast("Failed to stop recording");
  //   }
  // }

  // void deleteRecording() {
  //   HapticFeedback.lightImpact();
  //   try {
  //     if (isRecording.value) {
  //       flutterRecorder!.stopRecorder();
  //     }
  //     if (isPlaying.value) {
  //       flutterPlayer!.stopPlayer();
  //     }
      
  //     selectedFile.value = null;
  //     isRecording.value = false;
  //     showAudioPreview.value = false;
  //     isRecordingPaused.value = false;
  //     isPlaying.value = false;
  //     _audioFilePath = null;
  //   } catch (e) {
  //     debugPrint("Error deleting recording: $e");
  //   }
  // }

  // Future<void> resumeRecording() async {
  //   try {
  //     if (_audioFilePath == null) {
  //       CustomSnackbar.showErrorToast("No recording to resume");
  //       return;
  //     }
      
  //     await flutterRecorder!.resumeRecorder();
  //     isRecordingPaused.value = false;
  //   } catch (e) {
  //     debugPrint("Error resuming recording: $e");
  //     CustomSnackbar.showErrorToast("Failed to resume recording");
  //   }
  // }

  // Future<void> togglePlayback() async {
  //   try {
  //     if (selectedFile.value == null ||
  //         !isAudioFile(selectedFile.value!.path)) {
  //       CustomSnackbar.showErrorToast("Invalid audio file");
  //       return;
  //     }

  //     // Ensure player is initialized
  //     if (!isFlutterPlayerInitiated.value) {
  //       await initialize();
  //     }

  //     if (isPlaying.value) {
  //       await flutterPlayer!.pausePlayer();
  //       isPlaying.value = false;
  //       return;
  //     }

  //     await flutterPlayer!.startPlayer(
  //       fromURI: selectedFile.value!.path,
  //       codec: Codec.aacADTS,
  //       whenFinished: () {
  //         isPlaying.value = false;
  //       },
  //     );
  //     isPlaying.value = true;
  //   } catch (e) {
  //     debugPrint("Error toggling playback: $e");
  //     CustomSnackbar.showErrorToast("Error playing audio");
  //     isPlaying.value = false;
  //   }
  // }

  // Future<void> stopPlayback() async {
  //   try {
  //     if (isPlaying.value) {
  //       await flutterPlayer!.stopPlayer();
  //       isPlaying.value = false;
  //     }
  //   } catch (e) {
  //     debugPrint("Error stopping playback: $e");
  //   }
  // }

  // // Reset all state
  // void resetState() {
  //   try {
  //     if (isPlaying.value) {
  //       flutterPlayer!.stopPlayer();
  //     }
  //     if (isRecording.value) {
  //       flutterRecorder!.stopRecorder();
  //     }
      
  //     selectedFile.value = null;
  //     showAudioPreview.value = false;
  //     isPlaying.value = false;
  //     isRecording.value = false;
  //     isRecordingPaused.value = false;
  //     _audioFilePath = null;
  //   } catch (e) {
  //     debugPrint("Error resetting state: $e");
  //   }
  // }

  // @override
  // void onClose() {
  //   resetState();
  //   flutterPlayer?.closePlayer();
  //   flutterPlayer = null;
  //   flutterRecorder?.closeRecorder();
  //   flutterRecorder = null;
  //   super.onClose();
  // }
}