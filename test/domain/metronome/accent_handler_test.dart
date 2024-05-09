import 'package:flutter_test/flutter_test.dart';
import 'package:metronome/domain/metronome/accent_handler.dart';

void main() {
  late AccentHandler accent;

  setUp(() => accent = AccentHandler());
  group("_accent", () {
    test("check is Empty, should return true", () {
      //Act
      final result = accent.isEmpty;
      //Assert
      expect(result, true);
    });
    test("check is Empty, should return list of length 4", () {
      //Arrange
      int expectation = 4;
      //Act
      accent.emptyGuard();
      final result = accent.show;
      //Assert
      expect(result.length, expectation);
    });
    test("change Accent, accent should be change", () {
      //Arrange
      int numbersOfAccents = 4;
      var highAccent = Accent.high;
      accent.initAccents(numbersOfAccents);

      //Act
      accent.changeAccent(2, highAccent);
      //Assert
      expect(accent.getAccent(2), highAccent);
    });
  });
}
