
// import 'package:Vetted/app/modules/chat/controller/chat_controller.dart';
// import 'package:Vetted/app/modules/chat/widgets/shared/custom_audio_wave.dart';
// import 'package:Vetted/app/resources/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AudioInputPreview extends StatelessWidget {
  // final ChatController controller;
  // const AudioInputPreview({super.key, required this.controller});

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     // decoration: chatInputFieldDecoration(),
  //     width: Get.width,
  //     padding: const EdgeInsets.only(top: 10, right: 10, bottom: 4),
  //     child: Column(
  //       children: [
  //         Obx(() {
  //           if (!controller.audioController.isRecordingPaused.value) {
  //             return Row(
  //               children: [
  //                 // StreamBuilder(
  //                 //   stream: controller
  //                 //       .audioController.flutterRecorder.onCurrentDuration,
  //                 //   builder: (context, snapshot) {
  //                 //     if (!snapshot.hasData || snapshot.data == null) {
  //                 //       Padding(
  //                 //         padding: const EdgeInsets.only(left: 8.0),
  //                 //         child: Text(
  //                 //           _formatDuration(
  //                 //             controller.audioController.flutterRecorder
  //                 //                 .elapsedDuration,
  //                 //           ),
  //                 //           style: GoogleFonts.montserrat(
  //                 //             fontWeight: FontWeight.bold,
  //                 //             color: AppColors.primaryColor,
  //                 //           ),
  //                 //         ),
  //                 //       );
  //                 //     }
  //                 //     return Padding(
  //                 //       padding: const EdgeInsets.only(left: 8.0),
  //                 //       child: Text(
  //                 //         _formatDuration(snapshot.data),
  //                 //         style: GoogleFonts.montserrat(
  //                 //           fontWeight: FontWeight.bold,
  //                 //           color: AppColors.primaryColor,
  //                 //         ),
  //                 //       ),
  //                 //     );
  //                 //   },
  //                 // ),
  //                 // const SizedBox(width: 5),
  //                 Expanded(
  //                   child: LinearProgressIndicator(
  //                     color: AppColors.primaryColor,
  //                   ),
  //                 ),
  //               ],
  //             );
  //           }
  //           return playRecorded(context);
  //         }),
  //         const SizedBox(height: 10),
  //         Row(
  //           children: [
  //             IconButton(
  //               icon: const Icon(Icons.delete, color: Colors.red, size: 30),
  //               onPressed: controller.audioController.deleteRecording,
  //             ),
  //             const Spacer(),
  //             Obx(() {
  //               final isRecordingPaused =
  //                   controller.audioController.isRecordingPaused;
  //               return IconButton(
  //                 onPressed:
  //                     !isRecordingPaused.value
  //                         ? controller.audioController.pauseRecording
  //                         : controller.audioController.resumeRecording,
  //                 icon: Icon(
  //                   !isRecordingPaused.value ? Icons.pause : Icons.mic,
  //                   color: Colors.red,
  //                   size: 30,
  //                 ),
  //               );
  //             }),
  //             const Spacer(),
  //             CircleAvatar(
  //               radius: 24,
  //               backgroundColor: AppColors.primaryColor,
  //               child: IconButton(
  //                 icon: const Icon(Icons.send, color: Colors.white),
  //                 onPressed: controller.sendMessage,
  //                 // onPressed: controller.audioController.isRecording.value
  //                 //     ? controller.audioController.stopRecording
  //                 //     : controller.audioController.startRecording,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // String formatDuration(Duration? duration) {
  //   if (duration == null) return "";
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return '$minutes:$seconds';
  // }

  // Widget playRecorded(BuildContext context) {
  //   return Row(
  //     children: [
  //       Obx(() {
  //         return AnimatedSwitcher(
  //           duration: const Duration(milliseconds: 300),
  //           child:
  //               controller.audioController.isPlaying.value
  //                   ? IconButton(
  //                     onPressed: () async {
  //                       controller.audioController.isPlaying.value = false;
  //                       await controller.audioController.flutterPlayer!
  //                           .pausePlayer();
  //                     },
  //                     icon: const Icon(Icons.pause),
  //                   )
  //                   : IconButton(
  //                     onPressed: () async {
  //                       controller.audioController.isPlaying.value = true;
  //                       await controller.audioController.flutterPlayer!
  //                           .startPlayer();
  //                     },
  //                     icon: const Icon(Icons.play_arrow),
  //                   ),
  //         );
  //       }),
  //       const SizedBox(width: 5),
  //       Expanded(
  //         child: CustomAudioWaveform(
  //           // size: Size(MediaQuery.of(context).size.width * 0.8, 50),
  //           player: controller.audioController.flutterPlayer!,
  //           enableSeekGesture: true,
  //           // continuousWaveform: true,
  //           // playerWaveStyle: const PlayerWaveStyle(
  //           //   fixedWaveColor: Colors.grey,
  //           //   liveWaveColor: Colors.orange,
  //           //   spacing: 6.0,
  //           // ),
  //         ),
  //       ),
  //       // Expanded(
  //       //   child: AudioFileWaveforms(
  //       //     size: Size(MediaQuery.of(context).size.width * 0.8, 50),
  //       //     playerController: controller.audioController.playerController,
  //       //     enableSeekGesture: true,
  //       //     continuousWaveform: true,
  //       //     playerWaveStyle: const PlayerWaveStyle(
  //       //       fixedWaveColor: Colors.grey,
  //       //       liveWaveColor: Colors.orange,
  //       //       spacing: 6.0,
  //       //     ),
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }
// }
