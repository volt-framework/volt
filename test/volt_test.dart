import 'package:test/test.dart';
import 'package:volt/volt.dart';

const ulidAYear = 2020;
const ulidBYear = 2021;

const ulidString = '00000000000000000000000000';

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

    test('ULIDs should be parsed and converted to string correctly', () {
      expect(Ulid(ulidString).toString(), ulidString);
    });
  });
}
