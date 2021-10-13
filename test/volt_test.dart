import 'package:test/test.dart';
import 'package:volt/volt.dart';

const ulidAYear = 2020;
const ulidBYear = 2021;

final ulidA = Ulid.fromTimestamp(DateTime.utc(ulidAYear));
final ulidB = Ulid.fromTimestamp(DateTime.utc(ulidBYear));

final client = VoltRest('dummy_token');

void main() {
  group('Test ULIDs', () {
    test('ULIDs should have correct timestamps', () {
      expect(ulidA.toTimestamp().year, ulidAYear);
      expect(ulidB.toTimestamp().year, ulidBYear);
    });
    test('ULIDs should be compared correctly', () {
      expect(ulidA.compareTo(ulidB), -1);
    });
  });
}
