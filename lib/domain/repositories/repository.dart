abstract interface class Repository<T, K extends Object> {
  /// Returns an immutable snapshot, not a live view.
  List<T> getAll();

  /// Returns null when the entity does not exist.
  T? getById(K id);

  /// Inserts or replaces an entity with the same key.
  void save(T entity);

  /// Throws StateError when the entity does not exist.
  void delete(K id);
}
