part of volt;

class _IterUtils {
  static T? findOne<T>(Iterable<T> values, bool Function(T item) predicate) {
    try {
      return values.firstWhere(predicate);
    } catch (e) {
      return null;
    }
  }
}
