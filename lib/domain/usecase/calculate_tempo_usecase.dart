import 'package:metronome/domain/metronome/manual_tempo_calculator.dart';

const int _minuteInMilliseconds = 60000;

class CalculateTempoUsecase extends ManualTempoCalculator {
  DateTime? start;
  DateTime? end;
  @override
  int onSet() {
    if (start == null || end == null) {
      start = _setValueToCurrentTime();
      return 60;
    } else {
      start = _setValueToCurrentTime();
      int difference = _calculateDifferenceBetweenStartStop(start, end);
      return calculateTempo(difference);
    }
  }

  @override
  int onStop() {
    end = _setValueToCurrentTime();

    int timeInMilliseconds = _calculateDifferenceBetweenStartStop(end, start);
    return calculateTempo(timeInMilliseconds);
  }

  int calculateTempo(int timeInMilliseconds) {
    int calculate = (_minuteInMilliseconds) ~/ timeInMilliseconds;

    return calculate;
  }

  DateTime _setValueToCurrentTime() {
    return DateTime.now();
  }

  int _calculateDifferenceBetweenStartStop(DateTime? first, DateTime? second) {
    if (start != null && end != null) {
      return first!.difference(second!).inMilliseconds;
    } else {
      return 3000;
    }
  }
}
