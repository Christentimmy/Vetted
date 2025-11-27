import 'package:flutter_test/flutter_test.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

void main() {

  testWidgets('audio_waveforms plugin loads without crash', (tester) async {
    expect(() {
      final recorder = RecorderController();
      recorder.dispose();
    }, returnsNormally);
  });
}