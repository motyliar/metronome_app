import 'package:metronome/domain/metronome/metronome_tick.dart';

class StopPlayerUsecase {
  const StopPlayerUsecase({required MetronomeTick metronome})
      : _metronome = metronome;
  final MetronomeTick _metronome;

  void execute() {
    return _metronome.stop();
  }
}
