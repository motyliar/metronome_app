import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/native_comunicator/native_communicator.dart';

class ConnectUsecase {
  const ConnectUsecase({required NativeCommunicator native})
      : _nativeCommunicator = native;
  final NativeCommunicator _nativeCommunicator;

  Future<void> execute(AudioInputs inputs) {
    return _nativeCommunicator.connect(inputs);
  }
}
