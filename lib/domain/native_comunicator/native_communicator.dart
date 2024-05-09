import 'package:metronome/domain/inputs/audio_inputs.dart';

abstract class NativeCommunicator {
  Future<void> connect(AudioInputs inputs);
}
