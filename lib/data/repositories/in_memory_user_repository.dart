import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/user.dart';
import 'package:esme26/domain/repositories/user_repository.dart';

class InMemoryUserRepository extends InMemoryRepository<User, String>
    implements UserRepository {
  User? user = MockData.customer;

  InMemoryUserRepository()
    : super(MockData.users, keyOf: (item) => requireRepositoryId(item.id));

  @override
  User? getUser() => user;

  @override
  void setUser(User user) {
    if (user.id != null) {
      save(user);
    }
    this.user = user;
  }

  @override
  void save(User entity) {
    super.save(entity);
    if (user?.id == entity.id) {
      user = entity;
    }
  }

  @override
  void delete(String id) {
    super.delete(id);
    if (user?.id == id) {
      user = null;
    }
  }

  @override
  void reset() {
    super.reset();
    user = MockData.customer;
  }
}
