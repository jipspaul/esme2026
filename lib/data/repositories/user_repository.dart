import 'package:esme26/data/repositories/user_repository_JP.dart';
import 'package:esme26/domain/repositories/user_repository.dart' as domain;

abstract class UserRepository implements domain.UserRepository {
  static final UserRepository instance = UserRepositoryJP();
}
