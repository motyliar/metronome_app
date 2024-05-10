import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/inputs/metronome_d.dart';
import 'package:metronome/domain/metronome/accent_handler.dart';
import 'package:metronome/domain/metronome/audio_asset.dart';

import 'package:metronome/domain/usecase/send_message_usecase.dart';
import 'package:metronome/domain/usecase/start_usecase.dart';
import 'package:metronome/domain/usecase/stop_player_usecase.dart';

part 'metronome_state.dart';

const int _minuteInMilliseconds = 60000;

class MetronomeCubit extends Cubit<MetronomeState> {
  final StartTimerUsecase _start;
  final StopPlayerUsecase _stop;
  final ConnectUsecase _send;

  MetronomeCubit({
    required StartTimerUsecase start,
    required StopPlayerUsecase stop,
    required ConnectUsecase send,
  })  : _start = start,
        _stop = stop,
        _send = send,
        super(MetronomeState(accents: AccentHandler()));
  StreamSubscription? sub;

  void sendMessageToNative() {
    int duration = _minuteInMilliseconds ~/ state.tempo;
    sub = _start
        .execute(MetronomeInputs(durationInMilliseconds: duration))
        .listen((event) {
      emit(MetronomeState(
          metrum: (event % state.tick) + 1,
          tick: state.tick,
          accents: state.accents,
          asset: state.asset,
          tempo: state.tempo));
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
    emit(
      MetronomeState(
        metrum: state.metrum,
        tick: 5,
        accents: accents,
        asset: state.asset,
        tempo: state.tempo,
      ),
    );
  }

  void changeAccent(int index, Accent accent) {
    final accents = state.accents;
    accents.changeAccent(index, accent);
    emit(
      MetronomeState(
        metrum: state.metrum,
        tick: state.tick,
        accents: accents,
        asset: state.asset,
        tempo: state.tempo,
      ),
    );
  }

  void setAudio(AudioAsset asset) {
    emit(
      MetronomeState(
        accents: state.accents,
        metrum: state.metrum,
        tick: state.tick,
        asset: asset,
        tempo: state.tempo,
      ),
    );
  }

  void setTempo(int durationInMilliseconds) {
    emit(state.copyWith(tempo: durationInMilliseconds));
    sub?.cancel();
    _stop.execute();
    sendMessageToNative();
  }
}
