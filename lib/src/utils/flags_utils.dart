part of volt;

class FlagsUtils {
  static bool isApplied(int flags, int flag) {
    return (flags & flag) == flag;
  }

  static int apply(int field, bool? applies, int shift) {
    if (applies == null || applies == false) return field;
    return field | shift;
  }
}
