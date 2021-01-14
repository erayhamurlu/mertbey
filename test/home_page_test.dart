// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:trellocards/home_page.dart';

void main() {
  group('Counter', () {
    test('value should start at 0', () {
      expect(HomePageState().myCards, 0);
    });

    test('value should be incremented', () {
      final counter = HomePageState();

      counter.addCard();

      expect(counter.myCards, 1);
    });

    test('value should be decremented', () {
      final counter = HomePageState();

      counter.deleteCards();

      expect(counter.myCards, -1);
    });
  });
}
