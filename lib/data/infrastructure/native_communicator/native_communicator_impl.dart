import 'package:flutter/services.dart';
import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/native_comunicator/native_communicator.dart';

const String _channelName = "metronome";
const String _playMethod = "PLAY";
const String _initMethod = "INIT";

class NativeCommunicatorImpl extends NativeCommunicator {
  NativeCommunicatorImpl() {
    channel = _createChannel();
  }
  MethodChannel? channel;
  @override
  Future<void> connect(AudioInputs inputs) async {
    final arguments = _inputToArgument(inputs);

    await channel?.invokeMethod(_playMethod, arguments);
  }

  @override
  Future<void> init() async {
    channel?.invokeMethod(_initMethod);
  }

  Map<String, dynamic> _inputToArgument(AudioInputs inputs) =>
      {"audio": inputs.assets.name, "accent": inputs.accent.name};

  MethodChannel _createChannel() {
    const channel = MethodChannel(_channelName);
    return channel;
  }
}
