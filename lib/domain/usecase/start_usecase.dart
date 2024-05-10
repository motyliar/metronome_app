import 'dart:async';

import 'package:metronome/domain/metronome/metronome_tick.dart';
import 'package:metronome/domain/inputs/metronome_d.dart';

class StartTimerUsecase {
  const StartTimerUsecase({required MetronomeTick tick}) : _tick = tick;
  final MetronomeTick _tick;

  Stream<int> execute(MetronomeInputs inputs) {
    return _tick.start(inputs);
  }
}
