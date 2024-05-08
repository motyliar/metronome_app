import 'package:metronome/domain/entity/metronome_tick.dart';
import 'package:metronome/domain/inputs/metronome_d.dart';

class StartTimerUsecase {
  const StartTimerUsecase({required MetronomeTick tick}) : _tick = tick;
  final MetronomeTick _tick;

  void execute(MetronomeInputs inputs) {
    return _tick.start(inputs);
  }
}
