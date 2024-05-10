import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/inputs/metronome_d.dart';
import 'package:metronome/domain/metronome/accent_handler.dart';
import 'package:metronome/domain/metronome/audio_asset.dart';
import 'package:metronome/domain/usecase/calculate_tempo_usecase.dart';

import 'package:metronome/domain/usecase/send_message_usecase.dart';
import 'package:metronome/domain/usecase/start_usecase.dart';
import 'package:metronome/domain/usecase/stop_player_usecase.dart';

part 'metronome_state.dart';

class MetronomeCubit extends Cubit<MetronomeState> {
  final StartTimerUsecase _start;
  final StopPlayerUsecase _stop;
  final ConnectUsecase _send;
  final CalculateTempoUsecase _calculate;
  MetronomeCubit({
    required StartTimerUsecase start,
    required StopPlayerUsecase stop,
    required ConnectUsecase send,
    required CalculateTempoUsecase calculate,
  })  : _start = start,
        _stop = stop,
        _send = send,
        _calculate = calculate,
        super(MetronomeState(accents: AccentHandler()));
  StreamSubscription? sub;
  void sendMessageToNative() {
    sub = _start
        .execute(const MetronomeInputs(durationInMilliseconds: 180))
        .listen((event) {
      emit(MetronomeState(
          metrum: (event % state.tick) + 1,
          tick: state.tick,
          accents: state.accents,
          asset: state.asset));
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
      _stop.execute();
    }
  }

  void changeMetrum() {
    final accents = AccentHandler();
    accents.initAccents(5);
    emit(MetronomeState(
        metrum: state.metrum, tick: 5, accents: accents, asset: state.asset));
  }

  void changeAccent(int index, Accent accent) {
    final accents = state.accents;
    accents.changeAccent(index, accent);
    emit(MetronomeState(
        metrum: state.metrum,
        tick: state.tick,
        accents: accents,
        asset: state.asset));
  }

  void setAudio(AudioAsset asset) {
    emit(MetronomeState(
        accents: state.accents,
        metrum: state.metrum,
        tick: state.tick,
        asset: asset));
  }
}
