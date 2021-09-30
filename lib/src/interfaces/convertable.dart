part of volt;

abstract class Convertable<T extends Builder> {
  /// Convert object to builder.
  T toBuilder();
}
