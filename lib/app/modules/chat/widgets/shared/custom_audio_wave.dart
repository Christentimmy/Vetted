

// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'dart:math' as math;

// class CustomAudioWaveform extends StatefulWidget {
//   final FlutterSoundPlayer player;
//   final Color fixedWaveColor;
//   final Color liveWaveColor;
//   final double width;
//   final double height;
//   final bool enableSeekGesture;
//   final int barCount;
//   final double spacing;
//   final double waveThickness;

//   const CustomAudioWaveform({
//     super.key,
//     required this.player,
//     this.fixedWaveColor = Colors.grey,
//     this.liveWaveColor = Colors.blue,
//     this.width = 200,
//     this.height = 40,
//     this.enableSeekGesture = true,
//     this.barCount = 50,
//     this.spacing = 4,
//     this.waveThickness = 2,
//   });

//   @override
//   State<CustomAudioWaveform> createState() => _CustomAudioWaveformState();
// }

// class _CustomAudioWaveformState extends State<CustomAudioWaveform> {
//   double _progress = 0.0;
//   Duration _currentPosition = Duration.zero;
//   Duration _totalDuration = Duration.zero;
//   List<double> _waveformData = [];

//   @override
//   void initState() {
//     super.initState();
//     _generateWaveformData();
//     _listenToProgress();
//   }

//   void _generateWaveformData() {
//     // Generate pseudo-random waveform bars for visual appeal
//     final random = math.Random(42); // Fixed seed for consistent look
//     _waveformData = List.generate(
//       widget.barCount,
//       (index) {
//         // Create a wave-like pattern with random variations
//         double base = math.sin(index * 0.3) * 0.5 + 0.5;
//         double randomFactor = random.nextDouble() * 0.4 + 0.3;
//         return (base * randomFactor).clamp(0.2, 1.0);
//       },
//     );
//   }

//   void _listenToProgress() {
//     widget.player.onProgress?.listen((event) {
//       if (mounted) {
//         setState(() {
//           _currentPosition = event.position;
//           _totalDuration = event.duration;
//           if (_totalDuration.inMilliseconds > 0) {
//             _progress = _currentPosition.inMilliseconds / 
//                        _totalDuration.inMilliseconds;
//             _progress = _progress.clamp(0.0, 1.0);
//           }
//         });
//       }
//     });
//   }

//   void _onSeek(double localX) {
//     if (!widget.enableSeekGesture) return;
//     if (_totalDuration.inMilliseconds == 0) return;

//     final seekPosition = (localX / widget.width).clamp(0.0, 1.0);
//     final seekTime = Duration(
//       milliseconds: (_totalDuration.inMilliseconds * seekPosition).round(),
//     );

//     widget.player.seekToPlayer(seekTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: widget.enableSeekGesture
//           ? (details) => _onSeek(details.localPosition.dx)
//           : null,
//       onHorizontalDragUpdate: widget.enableSeekGesture
//           ? (details) => _onSeek(details.localPosition.dx)
//           : null,
//       child: Container(
//         width: widget.width,
//         height: widget.height,
//         child: CustomPaint(
//           painter: _WaveformPainter(
//             waveformData: _waveformData,
//             progress: _progress,
//             fixedWaveColor: widget.fixedWaveColor,
//             liveWaveColor: widget.liveWaveColor,
//             spacing: widget.spacing,
//             waveThickness: widget.waveThickness,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _WaveformPainter extends CustomPainter {
//   final List<double> waveformData;
//   final double progress;
//   final Color fixedWaveColor;
//   final Color liveWaveColor;
//   final double spacing;
//   final double waveThickness;

//   _WaveformPainter({
//     required this.waveformData,
//     required this.progress,
//     required this.fixedWaveColor,
//     required this.liveWaveColor,
//     required this.spacing,
//     required this.waveThickness,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     if (waveformData.isEmpty) return;

//     final barCount = waveformData.length;
//     final totalSpacing = spacing * (barCount - 1);
//     final availableWidth = size.width - totalSpacing;
//     final barWidth = (availableWidth / barCount).clamp(waveThickness, 10.0);
    
//     final progressBarIndex = (barCount * progress).floor();

//     for (int i = 0; i < barCount; i++) {
//       final x = i * (barWidth + spacing);
//       final normalizedHeight = waveformData[i];
//       final barHeight = size.height * normalizedHeight;
//       final y = (size.height - barHeight) / 2;

//       final paint = Paint()
//         ..color = i <= progressBarIndex ? liveWaveColor : fixedWaveColor
//         ..strokeWidth = barWidth
//         ..strokeCap = StrokeCap.round;

//       canvas.drawLine(
//         Offset(x + barWidth / 2, y),
//         Offset(x + barWidth / 2, y + barHeight),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant _WaveformPainter oldDelegate) {
//     return oldDelegate.progress != progress ||
//         oldDelegate.waveformData != waveformData ||
//         oldDelegate.fixedWaveColor != fixedWaveColor ||
//         oldDelegate.liveWaveColor != liveWaveColor;
//   }
// }

// // Extension method to format duration
// extension DurationFormatter on Duration {
//   String toMinutesSeconds() {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     String minutes = twoDigits(inMinutes.remainder(60));
//     String seconds = twoDigits(inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }