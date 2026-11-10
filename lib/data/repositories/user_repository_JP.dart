import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_user_repository.dart';
import 'package:esme26/data/repositories/user_repository.dart';
import 'package:esme26/domain/models/user.dart';

class UserRepositoryJP extends InMemoryUserRepository implements UserRepository {
  static final UserRepositoryJP _instance = UserRepositoryJP._internal();
  factory UserRepositoryJP() => _instance;
  UserRepositoryJP._internal();

  static final User mockUser = MockData.customer;
}
