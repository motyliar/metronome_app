import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/native_comunicator/native_communicator.dart';

const String _channelName = "metronome";
const String _methodName = "play";

class NativeCommunicatorImpl extends NativeCommunicator {
  @override
  void sendMessage(AudioInputs inputs) async {
    final arguments = _inputToArgument(inputs);
    final channel = _createChannel();
    await channel.invokeMethod("play", arguments);
  }

  Map<String, dynamic> _inputToArgument(AudioInputs inputs) =>
      {"audio": inputs.assets.name, "accent": inputs.accent.name};

  MethodChannel _createChannel() {
    const channel = MethodChannel(_channelName);
    return channel;
  }
}
