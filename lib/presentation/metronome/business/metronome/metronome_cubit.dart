import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:metronome/domain/inputs/audio_inputs.dart';
import 'package:metronome/domain/inputs/metronome_d.dart';
import 'package:metronome/domain/metronome/accent_handler.dart';
import 'package:metronome/domain/metronome/audio_asset.dart';
import 'package:metronome/domain/usecase/pause_metronome_usecase.dart';

import 'package:metronome/domain/usecase/send_message_usecase.dart';
import 'package:metronome/domain/usecase/start_usecase.dart';
import 'package:metronome/domain/usecase/stop_player_usecase.dart';
import 'package:metronome/shared/utils/debounce.dart';

part 'metronome_state.dart';

const int _minuteInMilliseconds = 60000;

class MetronomeCubit extends Cubit<MetronomeState> {
  final StartTimerUsecase _start;
  final StopPlayerUsecase _stop;
  final PauseMetronomeUsecase _pause;
  final ConnectUsecase _send;

  MetronomeCubit({
    required StartTimerUsecase start,
    required StopPlayerUsecase stop,
    required PauseMetronomeUsecase pause,
    required ConnectUsecase send,
  })  : _start = start,
        _stop = stop,
        _pause = pause,
        _send = send,
        super(MetronomeState(accents: AccentHandler()));
  StreamSubscription? sub;

  void sendMessageToNative() {
    int duration = _minuteInMilliseconds ~/ state.tempo;
    sub = _start
        .execute(MetronomeInputs(durationInMilliseconds: duration))
        .listen((event) {
      emit(state.copyWith(
        metrum: (event % state.tick) + 1,
      ));
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
    emit(state.copyWith(
      tick: accents.length,
      accents: accents,
    ));
  }

  void changeAccent(int index, Accent accent) {
    final accents = state.accents;
    accents.changeAccent(index, accent);
    emit(state.copyWith(accents: accents));
  }

  void setAudio(AudioAsset asset) {
    emit(state.copyWith(asset: asset));
  }

  Future<void> setTempo(int durationInMilliseconds) async {
    emit(state.copyWith(tempo: durationInMilliseconds));
    Debounce.run(() async {
      sub?.cancel();
      _pause.execute();
      await Future.delayed(
          const Duration(milliseconds: 100), () => sendMessageToNative());
    }, 100);
  }
}
