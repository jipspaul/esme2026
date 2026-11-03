import 'package:esme26/data/models/user.dart';
import 'package:esme26/data/repositories/user_repository_impl.dart';
import 'package:esme26/data/repositories/user_repository_JP.dart';

abstract class UserRepository {
  static final UserRepository instance = UserRepositoryJP();

  User? getUser();
  void setUser(User user);
}