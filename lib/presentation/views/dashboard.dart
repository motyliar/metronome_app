import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:metronome/data/infrastructure/metronome/metronome_tick_impl.dart';

import 'package:metronome/domain/metronome/accent_handler.dart';
import 'package:metronome/domain/metronome/audio_asset.dart';

import 'package:metronome/presentation/metronome/business/metronome/metronome_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/presentation/metronome/business/metronome/tempo_catcher/tempo_catcher_cubit.dart';
import 'package:metronome/shared/services/containers/metronome_locator.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final MetronomeTickImpl metronome = MetronomeTickImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => metronomeLocator<MetronomeCubit>(),
        ),
        BlocProvider(
          create: (context) => metronomeLocator<TempoCatcherCubit>(),
        ),
      ],
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
                  onPressed: () => context.read<MetronomeCubit>().stop(),
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
                const AudioAssetChooser(),
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
                const SizedBox(
                  height: 20,
                ),
                Text(state.tempo.toString()),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<TempoCatcherCubit, int>(
                  listener: (context, tempo) {
                    context.read<MetronomeCubit>().setTempo(tempo);
                  },
                  builder: (context, state) {
                    return BlocBuilder<TempoCatcherCubit, int>(
                      builder: (context, tempo) {
                        return GestureDetector(
                            onTap: () {
                              context.read<TempoCatcherCubit>().changeTempo();
                              print(tempo);
                            },
                            child: Container(
                              width: 200,
                              height: 100,
                              color: Colors.blue,
                              child: const Text("TAP TEMPO"),
                            ));
                      },
                    );
                  },
                )
              ],
            );
          },
        )),
      ),
    );
  }
}

class AudioAssetChooser extends StatelessWidget {
  const AudioAssetChooser({
    this.text = const <String>["square", "sine", "tambourine"],
    this.asset = const <AudioAsset>[
      AudioAsset.square,
      AudioAsset.sine,
      AudioAsset.tambourine
    ],
    super.key,
  });

  final List<String> text;
  final List<AudioAsset> asset;

  @override
  Widget build(BuildContext context) {
    int size = asset.length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        size,
        (index) => ElevatedButton(
          onPressed: () =>
              context.read<MetronomeCubit>().setAudio(asset[index]),
          child: Text(text[index]),
        ),
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
