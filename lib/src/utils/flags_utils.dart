part of volt;

class FlagsUtils {
  static bool isApplied(int flags, int flag) {
    return (flags & flag) == flag;
  }
}
