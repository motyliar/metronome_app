import 'package:metronome/domain/inputs/metronome_d.dart';

abstract class MetronomeTick {
  int start(MetronomeInputs inputs);
  void stop();
  void pause();
  void resume();
}
