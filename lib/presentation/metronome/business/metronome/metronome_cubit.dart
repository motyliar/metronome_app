import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/inputs/metronome_d.dart';
import 'package:metronome/domain/metronome/accent_handler.dart';
import 'package:metronome/domain/metronome/audio_asset.dart';

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
        super(MetronomeState(accents: AccentHandler()));
  StreamSubscription? sub;
  void sendMessageToNative() {
    sub = _start.execute(const MetronomeInputs()).listen((event) {
      emit(MetronomeState(
          metrum: (event % state.tick) + 1,
          tick: state.tick,
          accents: state.accents));
      int index = event % state.tick;

      _send.execute(
        AudioInputs(
          assets: state.asset,
          accent: state.accents.getAccent(index),
        ),
      );
    });
  }

  void stop() {
    if (sub != null) {
      sub?.cancel();
    }
  }

  void changeMetrum() {
    final accents = AccentHandler();
    accents.initAccents(5);
    emit(MetronomeState(metrum: state.metrum, tick: 5, accents: accents));
  }

  void changeAccent(int index, Accent accent) {
    final accents = state.accents;
    accents.changeAccent(index, accent);
    emit(MetronomeState(
        metrum: state.metrum, tick: state.tick, accents: accents));
  }
}
