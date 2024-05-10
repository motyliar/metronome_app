import 'package:metronome/domain/metronome/metronome_tick.dart';

class PauseMetronomeUsecase {
  const PauseMetronomeUsecase({required MetronomeTick metronome})
      : _metronome = metronome;
  final MetronomeTick _metronome;

  void execute() {
    return _metronome.pause();
  }
}
