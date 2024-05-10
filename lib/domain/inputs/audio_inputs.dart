import 'package:metronome/domain/metronome/accent_handler.dart';
import 'package:metronome/domain/metronome/audio_asset.dart';

class AudioInputs {
  const AudioInputs({required this.assets, required this.accent});
  final AudioAsset assets;
  final Accent accent;
}
