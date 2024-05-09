part of 'metronome_cubit.dart';

const List<String> _sounds = [
  "bartek",
  "robert",
  "waclaw",
  "krystian",
  "bogdan"
];

class MetronomeState extends Equatable {
  const MetronomeState({this.metrum = 0, this.tick = 4, this.sounds = _sounds});
  final int metrum;
  final int tick;
  final List<String> sounds;

  @override
  List<Object> get props => [metrum, tick, sounds];
}

final class MetronomeInitial extends MetronomeState {}
