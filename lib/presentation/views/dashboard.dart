import 'package:flutter/material.dart';
import 'package:metronome/data/infrastructure/metronome/metronome_tick_impl.dart';
import 'package:metronome/data/infrastructure/native_communicator/native_communicator_impl.dart';

import 'package:metronome/domain/usecase/send_message_usecase.dart';
import 'package:metronome/domain/usecase/start_usecase.dart';
import 'package:metronome/presentation/metronome/business/cubit/metronome_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final MetronomeTickImpl metronome = MetronomeTickImpl();
    return BlocProvider(
      create: (context) => MetronomeCubit(
          start: StartTimerUsecase(tick: MetronomeTickImpl()),
          send: SendMessageUsecase(native: NativeCommunicatorImpl())),
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<MetronomeCubit, MetronomeState>(
          builder: (context, state) {
            return Column(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.read<MetronomeCubit>().sendMessageToNative(),
                  child: const Text('Play'),
                ),
                ElevatedButton(
                  onPressed: () => metronome.stop(),
                  child: const Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: () => metronome.resume(),
                  child: const Text('Resume'),
                ),
                ElevatedButton(
                  onPressed: () => metronome.pause(),
                  child: const Text('Pause'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.read<MetronomeCubit>().changeMetrum(),
                  child: const Text('Metrum'),
                ),
                ElevatedButton(
                  onPressed: () => context.read<MetronomeCubit>().changeSound(),
                  child: const Text('Sound'),
                ),
                Text(state.metrum.toString())
              ],
            );
          },
        )),
      ),
    );
  }
}
