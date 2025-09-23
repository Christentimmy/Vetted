import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'dart:io';

enum VerificationStatus {
  initial,
  cameraInitializing,
  cameraReady,
  recording,
  processing,
  analysisComplete,
  error,
}

class GenderVerificationController extends GetxController {
  var verificationStatus = VerificationStatus.initial.obs;
  var detectedGender = ''.obs;
  var errorMessage = ''.obs;
  var isAccessGranted = false.obs;

  CameraController? cameraController;
  List<CameraDescription>? cameras;
  File? videoFile;

  final userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    initializeCamera();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    _disposeCamera();
    super.onClose();
  }

  Future<bool> _requestPermissions() async {
    try {
      final cameraStatus = await ph.Permission.camera.request();
      final audioStatus = await ph.Permission.microphone.request();

      if (cameraStatus.isDenied || audioStatus.isDenied) {
        errorMessage.value = 'Camera and microphone permissions are required';
        return false;
      }

      if (cameraStatus.isPermanentlyDenied || audioStatus.isPermanentlyDenied) {
        errorMessage.value = 'Please enable permissions in app settings';
        await ph.openAppSettings();
        return false;
      }

      return true;
    } catch (e) {
      errorMessage.value = 'Error requesting permissions: ${e.toString()}';
      return false;
    }
  }

  Future<void> initializeCamera() async {
    try {
      verificationStatus.value = VerificationStatus.cameraInitializing;

      // Request permissions first
      final hasPermission = await _requestPermissions();
      if (!hasPermission) {
        throw Exception('Required permissions not granted');
      }

      cameras = await availableCameras();
      if (cameras!.isEmpty) {
        throw Exception('No cameras available');
      }

      // Use front camera for better user experience
      CameraDescription frontCamera = cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras!.first,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.ultraHigh,
      );

      await cameraController!.initialize();
      verificationStatus.value = VerificationStatus.cameraReady;
    } catch (e) {
      errorMessage.value = 'Camera initialization failed: ${e.toString()}';
      verificationStatus.value = VerificationStatus.error;
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> startVideoRecording() async {
    try {
      if (cameraController == null || !cameraController!.value.isInitialized) {
        throw Exception('Camera not initialized');
      }

      verificationStatus.value = VerificationStatus.recording;
      await cameraController!.startVideoRecording();

      // Record for 5 seconds
      Future.delayed(Duration(seconds: 5), () {
        stopVideoRecording();
      });
    } catch (e) {
      errorMessage.value = 'Failed to start recording: ${e.toString()}';
      verificationStatus.value = VerificationStatus.error;
      debugPrint(e.toString());
    }
  }

  Future<void> stopVideoRecording() async {
    try {
      if (cameraController == null ||
          !cameraController!.value.isRecordingVideo) {
        return;
      }

      final recVideo = await cameraController!.stopVideoRecording();
      videoFile = File(recVideo.path);

      verificationStatus.value = VerificationStatus.processing;
      await analyzeVideo();
    } catch (e) {
      errorMessage.value = 'Failed to stop recording: ${e.toString()}';
      verificationStatus.value = VerificationStatus.error;
    }
  }

  Future<void> analyzeVideo() async {
    try {
      await endPointAnalysis();
      verificationStatus.value = VerificationStatus.analysisComplete;

      if (detectedGender.value == 'male') {
        isAccessGranted.value = true;
        Get.snackbar(
          'Verification Successful',
          'Access granted. Welcome!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Navigate to main app
        Get.offAllNamed(AppRoutes.bottomNavigationWidget);
      } else {
        isAccessGranted.value = false;
        Get.dialog(
          AlertDialog(
            title: Text('Access Denied'),
            content: Text(
              detectedGender.value == 'female'
                  ? 'This service is currently available for male users only.'
                  : 'Gender verification failed. Please try again with better lighting.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  resetVerification();
                },
                child: Text('Try Again'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      errorMessage.value = 'Analysis failed: ${e.toString()}';
      verificationStatus.value = VerificationStatus.error;
    }
  }

  Future<void> endPointAnalysis() async {
    if (videoFile == null) return;
    final gender = await userController.verifyGender(file: videoFile!);
    if (gender == null) return;
    detectedGender.value = gender;
  }

  void resetVerification() {
    verificationStatus.value = VerificationStatus.cameraReady;
    detectedGender.value = '';
    isAccessGranted.value = false;
    errorMessage.value = '';
  }

  void retryCamera() {
    initializeCamera();
  }

  Future<void> _disposeCamera() async {
    if (cameraController != null) {
      await cameraController!.dispose();
      cameraController = null;
    }
  }
}
