import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class MediaPlayerController extends GetxController {
  VideoPlayerController? _videoController;
  // final Rxn<FlutterSoundPlayer> flutterPlayer = Rxn<FlutterSoundPlayer>(null);

  final RxBool isPlaying = false.obs;
  final RxBool isLoading = false.obs;
  final RxString localPath = ''.obs;
  final RxBool hasInitialized = false.obs;

  bool _isCancelled = false;
  String? _oldMediaUrl;
  ValueKey waveFormKey = ValueKey(DateTime.now().microsecondsSinceEpoch);

  // Video Controller Management
  Future<void> initializeVideoController(String mediaUrl) async {
    if (_videoController != null) {
      _videoController!.dispose();
    }

    if (mediaUrl.isEmpty) return;

    _videoController = VideoPlayerController.networkUrl(Uri.parse(mediaUrl));

    _videoController!.addListener(() {
      if (!_isCancelled) update();
    });

    try {
      await _videoController!.initialize();
      if (!_isCancelled) {
        _videoController!.setVolume(1.0);
        hasInitialized.value = true;
      }
    } catch (error) {
      debugPrint("Video initialization error: $error");
    }
  }

  // Audio Controller Management
  Future<void> initializeAudioController(String mediaUrl) async {
    if (isLoading.value && mediaUrl == _oldMediaUrl) return;

    // Reset _isCancelled at the start of initialization
    _isCancelled = false;
    _oldMediaUrl = mediaUrl;

    isLoading.value = true;
    await _disposeAudioController();

    try {
      final downloadedPath = await _downloadAudio(mediaUrl);
      if (_isCancelled || downloadedPath.isEmpty) {
        isLoading.value = false;
        return;
      }

      localPath.value = downloadedPath;
      // flutterPlayer.value = FlutterSoundPlayer();

      // await flutterPlayer.value!.openPlayer();

      if (_isCancelled) {
        await _disposeAudioController();
        isLoading.value = false;
        return;
      }

      // Listen to player state changes
      // flutterPlayer.value!.onProgress!.listen((event) {
      //   if (!_isCancelled) {
      //     // Audio is playing if duration > 0 and position < duration
      //     // bool playing = event.position.inMilliseconds > 0 && 
      //     //               event.position < event.duration;
          
      //     // Check if playback finished
      //     if (event.position >= event.duration && event.duration.inMilliseconds > 0) {
      //       isPlaying.value = false;
      //       waveFormKey = ValueKey(DateTime.now().microsecondsSinceEpoch);
      //     }
      //   }
      // });

      hasInitialized.value = true;
    } catch (e) {
      debugPrint("Error initializing audio: $e");
      CustomSnackbar.showErrorToast("Error initializing audio");
      await _disposeAudioController();
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> _downloadAudio(String url) async {
    try {
      if (_isCancelled) return "";
      
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200 || _isCancelled) return "";

      final uri = Uri.parse(url);
      final filename = uri.pathSegments.last;
      final tempDir = await getTemporaryDirectory();
      final savePath = '${tempDir.path}/$filename';
      final saveFile = File(savePath);

      await saveFile.writeAsBytes(response.bodyBytes);
      return savePath;
    } catch (e) {
      debugPrint("Failed to download audio: $e");
      CustomSnackbar.showErrorToast("Failed to download audio");
      return "";
    }
  }

  Future<void> playPauseAudio() async {
    try {
      // Ensure _isCancelled is false before attempting to play
      if (_isCancelled) {
        _isCancelled = false;
      }

      // if (flutterPlayer.value == null) {
      //   // Handle reinitialization if needed
      //   if (localPath.value.isNotEmpty) {
      //     awaitreinitializeAudioController();
      //   }
      //   return;
      // }

      // final state = flutterPlayer.value!.playerState;

      // switch (state) {
      //   case PlayerState.isPlaying:
      //     await flutterPlayer.value!.pausePlayer();
      //     isPlaying.value = false;
      //     break;
          
      //   case PlayerState.isPaused:
      //     await flutterPlayer.value!.resumePlayer();
      //     isPlaying.value = true;
      //     break;
          
      //   case PlayerState.isStopped:
      //     await reinitializeAudioController();
      //     break;
          
      //   // default:
      //   //   // Start from beginning
      //   //   await flutterPlayer.value!.startPlayer(
      //   //     fromURI: localPath.value,
      //   //     codec: Codec.aacADTS,
      //   //     whenFinished: () {
      //   //       isPlaying.value = false;
      //   //       waveFormKey = ValueKey(DateTime.now().microsecondsSinceEpoch);
      //   //     },
      //   //   );
      //   //   isPlaying.value = true;
      // }
    } catch (e) {
      debugPrint("Error playing audio: $e");
      CustomSnackbar.showErrorToast("Error playing audio");
      isPlaying.value = false;
    }
  }

  Future<void> reinitializeAudioController() async {
    // try {
    //   // Reset _isCancelled when reinitializing
    //   _isCancelled = false;
      
    //   await _disposeAudioController();

    //   if (localPath.value.isEmpty) return;

    //   flutterPlayer.value = FlutterSoundPlayer();
    //   await flutterPlayer.value!.openPlayer();

    //   waveFormKey = ValueKey(DateTime.now().microsecondsSinceEpoch);

    //   if (!_isCancelled) {
    //     await flutterPlayer.value!.startPlayer(
    //       fromURI: localPath.value,
    //       codec: Codec.aacADTS,
    //       whenFinished: () {
    //         isPlaying.value = false;
    //         waveFormKey = ValueKey(DateTime.now().microsecondsSinceEpoch);
    //       },
    //     );
    //     isPlaying.value = true;
    //   }
    // } catch (e) {
    //   debugPrint("Error reinitializing audio: $e");
    //   isPlaying.value = false;
    // }
  }

  Future<void> _disposeAudioController() async {
    // if (flutterPlayer.value == null) return;

    // try {
    //   // Stop the player first to ensure clean disposal
    //   if (flutterPlayer.value!.playerState == PlayerState.isPlaying) {
    //     await flutterPlayer.value!.stopPlayer();
    //   }
    //   await flutterPlayer.value!.closePlayer();
    // } catch (e) {
    //   debugPrint("Error disposing audio controller: $e");
    // }
    // flutterPlayer.value = null;
    // isPlaying.value = false;
  }

  void reset() {
    _isCancelled = false;
    hasInitialized.value = false;
    isPlaying.value = false;
    isLoading.value = false;
    localPath.value = '';
    _oldMediaUrl = null;
  }

  VideoPlayerController? get videoController => _videoController;
  // Rxn<FlutterSoundPlayer> get flutterPlayerController => flutterPlayer;

  @override
  void onInit() {
    super.onInit();
    _isCancelled = false;
  }

  @override
  void onClose() {
    _isCancelled = true;
    
    // if (flutterPlayer.value != null) {
    //   try {
    //     flutterPlayer.value!.stopPlayer();
    //     flutterPlayer.value!.closePlayer();
    //   } catch (e) {
    //     debugPrint("Error closing player: $e");
    //   }
    // }

    _videoController?.dispose();
    super.onClose();
  }
}