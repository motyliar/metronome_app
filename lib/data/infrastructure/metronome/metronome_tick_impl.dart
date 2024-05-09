import 'dart:async';

import 'package:metronome/domain/inputs/metronome_d.dart';
import 'package:metronome/domain/metronome/metronome_tick.dart';

class MetronomeTickImpl implements MetronomeTick {
  StreamController<int>? controller;
  StreamSubscription<int>? sub;
  Timer? timer;
  int step = 0;

  @override
  void pause() {
    if (sub != null) sub?.pause();
    timer?.cancel();
  }

  @override
  void resume() {
    _streamInitializer(const MetronomeInputs().durationInMilliseconds);
  }

  @override
  Stream<int> start(MetronomeInputs inputs) {
    controller = null;
    controller = StreamController<int>();
    int step = 0;
    final stream = initStream();
    _streamInitializer(inputs.durationInMilliseconds);

    return stream;
  }

  @override
  void stop() {
    sub?.cancel();
    timer?.cancel();
    step = 0;
  }

  void _streamInitializer(int durationInMilliseconds) {
    Timer.run(() {
      controller?.add(step);
      timer = Timer.periodic(Duration(milliseconds: durationInMilliseconds),
          (timer) {
        step++;
        controller?.add(step);
      });
    });
  }

  Stream<int> initStream() {
    return controller!.stream;
  }
}

///
///dodac funkcje do anulowania wszystkiego przy inicjalizacji
