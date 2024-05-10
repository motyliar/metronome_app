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
      this.asset = AudioAsset.sine});
  final int metrum;
  final int tick;
  final AccentHandler accents;
  final AudioAsset asset;

  @override
  List<Object> get props => [metrum, tick, accents, asset];
}
