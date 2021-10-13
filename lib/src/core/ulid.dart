part of volt;

/// Represents ULID identification system used by Revolt.
/// Refers to https://github.com/agilord/ulid/
class Ulid implements Comparable<Ulid> {
  static final String _crockfordBase32 =
      '0123456789ABCDEFGHJKMNPQRSTVWXYZ'.toLowerCase();
  static final List<String> _base32 =
      List<String>.generate(32, (int i) => _crockfordBase32[i]);
  static final List<int> _lowercaseCodes =
      List<int>.generate(32, (int i) => _crockfordBase32[i].codeUnits.first);
  static final List<int> _base32Decode =
      List<int>.generate(256, (int i) => _lowercaseCodes.indexOf(i));

  final Uint8List _data;

  Ulid._(this._data);

  /// Create a [Ulid] instance.
  factory Ulid.fromTimestamp(DateTime timestamp) {
    final data = Uint8List(16);
    var ts = timestamp.millisecondsSinceEpoch;

    for (var i = 5; i >= 0; i--) {
      data[i] = ts & 0xFF;
      ts = ts >> 8;
    }

    for (var i = 6; i < 16; i++) {
      data[i] = Random.secure().nextInt(256);
    }

    return Ulid._(data);
  }

  factory Ulid.fromNow() => Ulid.fromTimestamp(DateTime.now());

  /// Parse [Ulid] from string.
  factory Ulid(String value) {
    if (value.length == 26) {
      return Ulid._(_parseBase32(value));
    }

    throw ArgumentError('Unable to recognize format: $value');
  }

  static Uint8List _parseBase32(String value) {
    final lc = value.toLowerCase();
    final data = Uint8List(16);
    final buffer = Uint8List(26);

    for (var i = 0; i < 26; i++) {
      buffer[i] = _base32Decode[lc.codeUnitAt(i)];
    }

    _decode(buffer, 0, 9, data, 0, 5); // time
    _decode(buffer, 10, 17, data, 6, 10); // random higher 40 bit
    _decode(buffer, 18, 25, data, 11, 15); // random lower 40 bit

    return data;
  }

  @override
  String toString() {
    final result = Uint8List(26);

    _encode(0, 5, result, 0, 9); // time
    _encode(6, 10, result, 10, 17); // random upper 40-bit
    _encode(11, 15, result, 18, 25); // random lower 40-bit

    final sb = StringBuffer();
    for (var i = 0; i < 26; i++) {
      sb.write(_base32[result[i]]);
    }

    return sb.toString().toUpperCase();
  }

  /// Get the millisecond component.
  DateTime toTimestamp() {
    var millis = 0;
    for (var i = 0; i < 6; i++) {
      millis = (millis << 8) + _data[i];
    }

    return DateTime.fromMillisecondsSinceEpoch(millis);
  }

  @override
  bool operator ==(other) {
    if (other is Ulid) {
      for (var i = 0; i < _data.length; i++) {
        if (other._data[i] != _data[i]) return false;
      }
      return true;
    }

    return false;
  }

  @override
  int get hashCode => _data.join().hashCode;

  void _encode(int inS, int inE, Uint8List buffer, int outS, int outE) {
    var value = BigInt.from(0);
    for (var i = inS; i <= inE; i++) {
      value = (value << 8) + BigInt.from(_data[i]);
    }
    for (var i = outE; i >= outS; i--) {
      buffer[i] = value.toInt() & 0x1F;
      value = value >> 5;
    }
  }

  static void _decode(
      Uint8List buffer, int inS, int inE, Uint8List data, int outS, int outE) {
    var value = BigInt.from(0);
    for (var i = inS; i <= inE; i++) {
      value = (value << 5) + BigInt.from(buffer[i]);
    }
    for (var i = outE; i >= outS; i--) {
      data[i] = value.toInt() & 0xFF;
      value = value >> 8;
    }
  }

  @override
  int compareTo(Ulid other) => toTimestamp().compareTo(other.toTimestamp());
}
