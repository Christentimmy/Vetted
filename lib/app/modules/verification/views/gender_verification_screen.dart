import 'package:Vetted/app/modules/verification/controller/gender_verification_controller.dart';
import 'package:Vetted/app/modules/verification/widgets/face_frame_painter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class GenderVerificationScreen extends StatelessWidget {
  GenderVerificationScreen({super.key});
  final controller = Get.put(GenderVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Identity Verification'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() => _buildContent()),
    );
  }

  Widget _buildContent() {
    switch (controller.verificationStatus.value) {
      case VerificationStatus.cameraInitializing:
        return _buildLoadingState('Initializing camera...');

      case VerificationStatus.cameraReady:
        return _buildCameraView();

      case VerificationStatus.recording:
        return _buildRecordingView();

      case VerificationStatus.processing:
        return _buildLoadingState('Analyzing video...');

      case VerificationStatus.analysisComplete:
        return _buildResultView();

      case VerificationStatus.error:
        return _buildErrorView();

      default:
        return _buildLoadingState('Loading...');
    }
  }

  Widget _buildLoadingState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blue),
          SizedBox(height: 24),
          Text(message, style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildCameraView() {
    if (controller.cameraController == null ||
        !controller.cameraController!.value.isInitialized) {
      return _buildLoadingState('Camera initializing...');
    }

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Center(child: CameraPreview(controller.cameraController!)),
              _buildCameraOverlay(),
            ],
          ),
        ),
        _buildCameraControls(),
      ],
    );
  }

  Widget _buildCameraOverlay() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: FaceFramePainter(),
        child: Column(
          children: [
            SizedBox(height: 60),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Position your face within the frame\nand press record for verification',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildRecordingView() {
    return Stack(
      children: [
        CameraPreview(controller.cameraController!),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.red.withValues(alpha: 0.02),
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              'REC',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 0,
          right: 0,
          child: Text(
            'Recording... Please look at the camera',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              controller.isAccessGranted.value
                  ? Icons.check_circle
                  : Icons.cancel,
              size: 80,
              color:
                  controller.isAccessGranted.value ? Colors.green : Colors.red,
            ),
            SizedBox(height: 24),
            Text(
              controller.isAccessGranted.value
                  ? 'Verification Successful'
                  : 'Access Denied',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            if (!controller.isAccessGranted.value)
              ElevatedButton(
                onPressed: controller.resetVerification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text('Try Again'),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 80, color: Colors.red),
            SizedBox(height: 24),
            Text(
              'Verification Error',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: controller.retryCamera,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraControls() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: controller.startVideoRecording,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Icon(Icons.videocam, color: Colors.white, size: 40),
            ),
          ),
        ],
      ),
    );
  }

}
