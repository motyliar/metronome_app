import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/native_comunicator/native_communicator.dart';

class SendMessageUsecase {
  const SendMessageUsecase({required NativeCommunicator native})
      : _nativeCommunicator = native;
  final NativeCommunicator _nativeCommunicator;

  void execute(AudioInputs inputs) {
    _nativeCommunicator.sendMessage(inputs);
  }
}
