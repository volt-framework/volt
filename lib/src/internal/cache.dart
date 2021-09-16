part of volt;

class Cache<K, V> implements Disposable {
  final Map<K, V> _cache = {};
  Map<K, V> get asMap => _cache;

  Iterable<V> get keys => _cache.values;
  Iterable<V> get values => _cache.values;

  V get first => _cache.values.first;
  V get last => _cache.values.last;

  int get count => _cache.length;

  Iterable<V> find(bool Function(V item) predicate) => values.where(predicate);
  V? findOne(bool Function(V item) predicate) {
    try {
      return values.firstWhere(predicate);
    } catch (e) {
      return null;
    }
  }

  V? operator [](K key) => _cache[key];
  void operator []=(K key, V item) => _cache[key] = item;

  // is it working? i didnt test it
  V addIfAbsent(K key, V value) => _cache[key] ??= value;

  bool hasKey(K key) => _cache.containsKey(key);
  bool hasValue(V value) => _cache.containsValue(value);

  void add(K key, V value) => _cache[key] = value;
  void addCache(Cache<K, V> cache) => addMap(cache.asMap);
  void addMap(Map<K, V> map) => _cache.addAll(map);

  void remove(K key) => _cache.remove(key);
  void removeWhere(bool Function(K key, V value) p) => _cache.removeWhere(p);
  void clear() => _cache.clear();

  void forEach(void Function(K, V) f) => _cache.forEach(f);

  Iterable<V> take(int count) => values.take(count);
  Iterable<V> takeLast(int count) =>
      values.toList().sublist(values.length - count);

  @override
  Future<void> dispose() async {
    _cache.clear();
  }
}
