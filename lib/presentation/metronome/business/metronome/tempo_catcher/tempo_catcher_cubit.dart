import 'package:bloc/bloc.dart';
import 'package:metronome/domain/usecase/calculate_tempo_usecase.dart';

class TempoCatcherCubit extends Cubit<int> {
  final CalculateTempoUsecase _calculate;
  TempoCatcherCubit({required CalculateTempoUsecase calculate})
      : _calculate = calculate,
        super(1000);

  bool _isCalculate = false;

  void changeTempo() {
    if (_isCalculate == true) {
      int tempo = _calculate.onStop();
      emit(tempo);
      _isCalculate = !_isCalculate;
    } else {
      _isCalculate = !_isCalculate;
      int tempo = _calculate.onSet();
      emit(tempo);
    }
  }
}
