import 'package:Vetted/app/controller/user_controller.dart';
import 'package:Vetted/app/widgets/custom_button.dart';
import 'package:Vetted/app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:image/image.dart' as img;

class NewVerificationScreen extends StatefulWidget {
  const NewVerificationScreen({super.key});

  @override
  State<NewVerificationScreen> createState() => _NewVerificationScreenState();
}

class _NewVerificationScreenState extends State<NewVerificationScreen> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  File? _capturedImage;

  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<bool> _requestPermissions() async {
    try {
      final cameraStatus = await ph.Permission.camera.request();
      final audioStatus = await ph.Permission.microphone.request();

      if (cameraStatus.isDenied || audioStatus.isDenied) {
        CustomSnackbar.showErrorToast(
          "Camera and microphone permissions are required",
        );
        return false;
      }

      if (cameraStatus.isPermanentlyDenied || audioStatus.isPermanentlyDenied) {
        CustomSnackbar.showErrorToast(
          "Please enable permissions in app settings",
        );
        await ph.openAppSettings();
        return false;
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> initializeCamera() async {
    try {
      final hasPermission = await _requestPermissions();
      if (!hasPermission) {
        throw Exception('Required permissions not granted');
      }

      _cameras = await availableCameras();
      if (_cameras!.isEmpty) {
        throw Exception('No cameras available');
      }

      // Use front camera for better user experience
      CameraDescription frontCamera = _cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras!.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.veryHigh,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<File> _flipImageIfFrontCamera(File imageFile) async {
    // Check if we're using front camera
    if (_cameraController?.description.lensDirection ==
        CameraLensDirection.front) {
      // Read the image
      final bytes = await imageFile.readAsBytes();
      img.Image? image = img.decodeImage(bytes);

      if (image != null) {
        // Flip horizontally
        img.Image flipped = img.flipHorizontal(image);

        // Save the flipped image
        final flippedBytes = img.encodeJpg(flipped);
        await imageFile.writeAsBytes(flippedBytes);
      }
    }

    return imageFile;
  }

  Future<void> _takePicture() async {
    HapticFeedback.lightImpact();
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final image = await _cameraController!.takePicture();
      File capturedFile = File(image.path);

      // Flip the image if using front camera
      capturedFile = await _flipImageIfFrontCamera(capturedFile);
      setState(() {
        _capturedImage = capturedFile;
      });
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  void _retakePicture() {
    setState(() {
      _capturedImage = null;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification'), centerTitle: true),
      body:
          _capturedImage != null ? _buildPreviewScreen() : _buildCameraScreen(),
    );
  }

  Widget _buildCameraScreen() {
    if (!_isCameraInitialized || _cameraController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Center(child: CameraPreview(_cameraController!)),
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Position your face in the frame',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          color: Colors.white,
          child: Column(
            children: [
              CustomButton(
                ontap: _takePicture,
                isLoading: false.obs,
                child: Text(
                  'Take Picture',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewScreen() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Image.file(File(_capturedImage!.path), fit: BoxFit.contain),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          color: Colors.white,
          child: Column(
            children: [
              CustomButton(
                ontap: () async {
                  if (_capturedImage == null) {
                    CustomSnackbar.showErrorToast("Please take a picture");
                    return;
                  }
                  await userController.verifyGender(file: _capturedImage!);
                },
                isLoading: userController.isloading,
                child: Text(
                  'Submit Verification',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 12),
              TextButton(
                onPressed: _retakePicture,
                child: const Text('Retake Photo'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
