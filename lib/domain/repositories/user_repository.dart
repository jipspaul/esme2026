import 'package:esme26/domain/models/user.dart';
import 'package:esme26/domain/repositories/repository.dart';

abstract interface class UserRepository implements Repository<User, String> {
  User? getUser();

  /// Selects the current user; drafts without an id are not added to the catalog.
  void setUser(User user);
}
