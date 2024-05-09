import 'package:metronome/domain/inputs/audio_inputs.dart';

abstract class NativeCommunicator {
  void sendMessage(AudioInputs inputs);
}
