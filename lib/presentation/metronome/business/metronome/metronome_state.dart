part of 'metronome_cubit.dart';

const List<String> _sounds = [
  "bartek",
  "robert",
  "waclaw",
  "krystian",
  "bogdan"
];

class MetronomeState extends Equatable {
  const MetronomeState(
      {required this.accents,
      this.metrum = 1,
      this.tick = 4,
      this.asset = AudioAsset.sine,
      this.tempo = 60});
  final int metrum;
  final int tick;
  final AccentHandler accents;
  final AudioAsset asset;
  final int tempo;

  MetronomeState copyWith(
          {int? metrum,
          int? tick,
          AccentHandler? accents,
          AudioAsset? asset,
          int? tempo}) =>
      MetronomeState(
        accents: accents ?? this.accents,
        metrum: metrum ?? this.metrum,
        tick: tick ?? this.tick,
        asset: asset ?? this.asset,
        tempo: tempo ?? this.tempo,
      );

  @override
  List<Object> get props => [metrum, tick, accents, asset, tempo];
}
