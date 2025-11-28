// import 'package:Vetted/app/modules/chat/widgets/shared/custom_audio_wave.dart';
// import 'package:Vetted/app/resources/colors.dart';
// import 'package:Vetted/app/modules/chat/controller/receiver_card_controller.dart';
// import 'package:Vetted/app/modules/chat/widgets/shared/base_audio_content_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/public/flutter_sound_player.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// // import 'package:audio_waveforms/audio_waveforms.dart';

// class ReceiverAudioContentWidget extends BaseAudioContentWidget {
//   final ReceiverCardController controller;

//   ReceiverAudioContentWidget({
//     super.key,
//     required super.messageModel,
//     required this.controller,
//   }) : super(isReceiver: true);

//   final List<double> _speeds = [1.0, 1.5, 2.0];
//   final RxInt _speedIndex = 0.obs;

//   @override
//   Widget buildPlayPauseButton() {
//     return InkWell(
//       onTap: () async {
//         if (controller.mediaController.flutterPlayer.value == null &&
//             !controller.mediaController.isLoading.value) {
//           await controller.ensureControllerInitialized(messageModel);
//         }
//         if (controller.mediaController.flutterPlayer.value != null &&
//             !controller.mediaController.isLoading.value) {
//           await controller.mediaController.playPauseAudio();
//         }
//       },
//       child: SizedBox(
//         width: 30,
//         height: 30,
//         child: Obx(
//           () =>
//               controller.mediaController.isLoading.value
//                   ? CircularProgressIndicator(color: iconColor, strokeWidth: 2)
//                   : Icon(
//                     controller.mediaController.isPlaying.value
//                         ? Icons.pause_circle_filled
//                         : Icons.play_circle_fill,
//                     color: iconColor,
//                     size: 30,
//                   ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget buildWaveform() {
//     return Obx(() {
//       final audioController = controller.mediaController.flutterPlayer;

//       // Show placeholder when no audio is loaded
//       if (audioController.value == null) {
//         return Container(
//           height: 40,
//           width: 100,
//           alignment: Alignment.center,
//           child: Container(height: 2, color: waveformFixedColor),
//         );
//       }

//       // Show custom waveform with flutter_sound player
//       return CustomAudioWaveform(
//         player: audioController.value!,
//         width: Get.width * 0.6,
//         height: 40,
//         fixedWaveColor: waveformFixedColor,
//         liveWaveColor: waveformLiveColor,
//         spacing: 6,
//         waveThickness: 2,
//         enableSeekGesture: true,
//         barCount: 50, // Adjust based on your design needs
//       );
//     });
//   }

//   @override
//   Widget buildSpeedButton() {
//     return Obx(() {
//       final audioController = controller.mediaController.flutterPlayer.value;
//       final isPlaying = controller.mediaController.isPlaying.value;
//       return AnimatedSwitcher(
//         // opacity: (audioController != null && isPlaying) ? 1.0 : 0.0,
//         duration: const Duration(milliseconds: 300),
//         child:
//             isPlaying
//                 ? _buildSpeedButton(audioController, isPlaying)
//                 : avaterBuilder(),
//       );
//     });
//   }

//   Widget avaterBuilder() {
//     return CircleAvatar(
//       radius: 22,
//        backgroundColor: AppColors.primaryColor,
//        child: Icon(FontAwesomeIcons.ghost, color: Colors.white),
//     );
//   }

//   Widget _buildSpeedButton(
//     FlutterSoundPlayer? audioController,
//     bool isPlaying,
//   ) {
//     if (audioController == null) return const SizedBox.shrink();
//     return TextButton(
//       style: TextButton.styleFrom(
//         minimumSize: const Size(36, 36),
//         padding: EdgeInsets.zero,
//       ),
//       onPressed: () {
//         _speedIndex.value = (_speedIndex.value + 1) % _speeds.length;
//         audioController.setSpeed(_speeds[_speedIndex.value]);
//       },
//       child: Obx(
//         () => Text(
//           '${_speeds[_speedIndex.value]}x',
//           style: TextStyle(
//             color: iconColor,
//             fontWeight: FontWeight.bold,
//             fontSize: 13,
//           ),
//         ),
//       ),
//     );
//   }
// }
