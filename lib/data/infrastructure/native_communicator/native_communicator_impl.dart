import 'package:flutter/material.dart';
import 'package:metronome/domain/native_comunicator/native_communicator.dart';

class NativeCommunicatorImpl extends NativeCommunicator {
  @override
  void sendMessage(String name) {
    debugPrint(name);
  }
}
