import 'dart:async';
import 'dart:ui';

class Debounce {
  static Timer? _debounceTimer;

  static Future<void> run(VoidCallback action, int millisecond) async {
    if (_debounceTimer != null) {
      _debounceTimer?.cancel();
    }
    Completer<void> completer = Completer<void>();
    _debounceTimer = Timer(Duration(milliseconds: millisecond), () {
      action();
      completer.complete();
    });
    await completer.future;
  }
}
