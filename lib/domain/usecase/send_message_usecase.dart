import 'package:metronome/domain/native_comunicator/native_communicator.dart';

class SendMessageUsecase {
  const SendMessageUsecase({required NativeCommunicator native})
      : _nativeCommunicator = native;
  final NativeCommunicator _nativeCommunicator;

  void execute(String name) {
    _nativeCommunicator.sendMessage(name);
  }
}
