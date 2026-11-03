import 'package:esme26/domain/repositories/repository.dart';

String requireRepositoryId(String? id) {
  if (id == null || id.trim().isEmpty) {
    throw ArgumentError.value(id, 'id', 'A nonblank persistent id is required');
  }
  return id;
}

class InMemoryRepository<T, K extends Object> implements Repository<T, K> {
  final K Function(T) keyOf;
  final List<T> _seed;
  final Map<K, T> _items = {};

  InMemoryRepository(Iterable<T> seed, {required this.keyOf})
    : _seed = List.unmodifiable(seed) {
    for (final entity in _seed) {
      final key = keyOf(entity);
      if (_items.containsKey(key)) {
        throw StateError('Duplicate mock key: $key');
      }
      _items[key] = entity;
    }
  }

  @override
  List<T> getAll() => List.unmodifiable(_items.values);

  @override
  T? getById(K id) => _items[id];

  @override
  void save(T entity) => _items[keyOf(entity)] = entity;

  @override
  void delete(K id) {
    if (!_items.containsKey(id)) {
      throw StateError('No entity with key: $id');
    }
    _items.remove(id);
  }

  /// Restores only this mock repository; it does not cascade to related stores.
  void reset() {
    _items.clear();
    for (final entity in _seed) {
      _items[keyOf(entity)] = entity;
    }
  }
}
