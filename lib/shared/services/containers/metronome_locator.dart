import 'package:get_it/get_it.dart';
import 'package:metronome/data/infrastructure/metronome/metronome_tick_impl.dart';
import 'package:metronome/data/infrastructure/native_communicator/native_communicator_impl.dart';
import 'package:metronome/domain/metronome/metronome_tick.dart';
import 'package:metronome/domain/native_comunicator/native_communicator.dart';
import 'package:metronome/domain/usecase/calculate_tempo_usecase.dart';
import 'package:metronome/domain/usecase/pause_metronome_usecase.dart';
import 'package:metronome/domain/usecase/send_message_usecase.dart';
import 'package:metronome/domain/usecase/start_usecase.dart';
import 'package:metronome/domain/usecase/stop_player_usecase.dart';
import 'package:metronome/presentation/metronome/business/metronome/metronome_cubit.dart';
import 'package:metronome/presentation/metronome/business/metronome/tempo_catcher/tempo_catcher_cubit.dart';

final metronomeLocator = GetIt.instance;

void initMetronome() {
  metronomeLocator
    ..registerFactory(
      () => MetronomeCubit(
        start: metronomeLocator(),
        stop: metronomeLocator(),
        pause: metronomeLocator(),
        send: metronomeLocator(),
      ),
    )
    ..registerFactory(() => TempoCatcherCubit(calculate: metronomeLocator()))
    ..registerLazySingleton(() => StartTimerUsecase(tick: metronomeLocator()))
    ..registerLazySingleton(
        () => StopPlayerUsecase(metronome: metronomeLocator()))
    ..registerLazySingleton(() => ConnectUsecase(native: metronomeLocator()))
    ..registerLazySingleton(
        () => PauseMetronomeUsecase(metronome: metronomeLocator()))
    ..registerLazySingleton(() => CalculateTempoUsecase())
    ..registerLazySingleton<MetronomeTick>(() => MetronomeTickImpl())
    ..registerLazySingleton<NativeCommunicator>(() => NativeCommunicatorImpl());
}
