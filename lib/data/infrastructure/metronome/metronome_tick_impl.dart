import 'dart:async';

import 'package:metronome/domain/inputs/metronome_d.dart';
import 'package:metronome/domain/metronome/metronome_tick.dart';

class MetronomeTickImpl implements MetronomeTick {
  late StreamSubscription<int> sub;

  @override
  void pause() {
    sub.pause();
  }

  @override
  void resume() {
    if (sub.isPaused) {
      sub.resume();
    }
  }

  @override
  int start(MetronomeInputs inputs) {
    int step = 0;
    sub = _streamInitializer(inputs.durationInMilliseconds).listen((event) {
      step = 0;
    });
    return step;
  }

  @override
  void stop() {
    sub.cancel();
  }

  Stream<int> _streamInitializer(int durationInMilliseconds) {
    return Stream.periodic(
        Duration(milliseconds: durationInMilliseconds), (value) => value);
  }
}
