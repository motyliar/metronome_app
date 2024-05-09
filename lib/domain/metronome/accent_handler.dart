enum Accent { high, low, mid }

const int _initMeterCount = 4;

class AccentHandler {
  AccentHandler() : _accents = <Accent>[] {
    emptyGuard();
  }

  List<Accent> _accents;

  List<Accent> get show => _accents;

  bool get isEmpty => _accents.isEmpty;
  bool get isNotEmpty => _accents.isNotEmpty;
  int get length => _accents.length;

  void emptyGuard() {
    if (isEmpty) {
      initAccents(_initMeterCount);
    }
  }

  Accent getAccent(int index) => _accents[index];

  void initAccents(int counts) {
    _accents =
        List.generate(counts, (index) => index == 0 ? Accent.high : Accent.low);
  }

  void changeAccent(int index, Accent accent) {
    _accents[index] = accent;
  }
}
