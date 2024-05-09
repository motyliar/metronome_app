import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:metronome/data/infrastructure/native_communicator/native_communicator_impl.dart';
import 'package:metronome/domain/inputs/metronome_d.dart';
import 'package:metronome/domain/native_comunicator/native_communicator.dart';
import 'package:metronome/domain/usecase/send_message_usecase.dart';
import 'package:metronome/domain/usecase/start_usecase.dart';

part 'metronome_state.dart';

class MetronomeCubit extends Cubit<MetronomeState> {
  final StartTimerUsecase _start;
  final SendMessageUsecase _send;
  MetronomeCubit(
      {required StartTimerUsecase start, required SendMessageUsecase send})
      : _start = start,
        _send = send,
        super(const MetronomeState());
  StreamSubscription? sub;
  void sendMessageToNative() {
    sub = _start.execute(const MetronomeInputs()).listen((event) {
      emit(MetronomeState(
          metrum: (event % state.tick) + 1,
          tick: state.tick,
          sounds: state.sounds));
      int index = event % state.tick;

      NativeCommunicatorImpl().sendMessage(state.sounds[index]);
    });
  }

  void stop() {
    if (sub != null) {
      sub?.cancel();
    }
  }

  void changeMetrum() {
    emit(MetronomeState(metrum: state.metrum, tick: 5, sounds: state.sounds));
  }

  void changeSound() {
    List<String> sounds = List.from(state.sounds);
    sounds[2] = "karolek";
    emit(
        MetronomeState(metrum: state.metrum, tick: state.tick, sounds: sounds));
  }
}
