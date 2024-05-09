import 'package:flutter/material.dart';
import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/native_comunicator/native_communicator.dart';

class NativeCommunicatorImpl extends NativeCommunicator {
  @override
  void sendMessage(AudioInputs inputs) {
    debugPrint(inputs.accent.name);
  }
}
