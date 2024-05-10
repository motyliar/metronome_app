import 'dart:async';

import 'package:metronome/domain/inputs/metronome_d.dart';

abstract class MetronomeTick {
  Stream<int> start(MetronomeInputs inputs);
  void stop();
  void pause();
  void resume();
}
