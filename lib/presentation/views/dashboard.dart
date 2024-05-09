import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metronome/data/infrastructure/metronome/metronome_tick_impl.dart';
import 'package:metronome/data/infrastructure/native_communicator/native_communicator_impl.dart';
import 'package:metronome/domain/metronome/accent_handler.dart';

import 'package:metronome/domain/usecase/send_message_usecase.dart';
import 'package:metronome/domain/usecase/start_usecase.dart';
import 'package:metronome/presentation/metronome/business/metronome/metronome_cubit.dart';
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
                  onPressed: () => context
                      .read<MetronomeCubit>()
                      .changeAccent(2, Accent.high),
                  child: const Text('Accent'),
                ),
                Text(state.metrum.toString()),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                        state.accents.length,
                        (index) => AccentBox(
                            accent: state.accents.getAccent(index),
                            color: getColor(state.metrum, index))),
                  ),
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}

class AccentBox extends StatelessWidget {
  const AccentBox({required this.accent, required this.color, super.key});
  final Accent accent;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: accentHeight(accent),
      color: color,
    );
  }
}

double accentHeight(Accent accent) {
  switch (accent) {
    case Accent.high:
      return 150;
    case Accent.low:
      return 75;
    case Accent.mid:
      return 115;
  }
}

Color getColor(int current, int accentIndex) {
  if (current == accentIndex + 1) {
    return Colors.amber;
  } else {
    return Colors.grey;
  }
}
