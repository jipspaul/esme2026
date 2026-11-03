import 'package:esme26/data/models/user.dart';
import 'package:esme26/data/models/adress.dart';
import 'package:esme26/data/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  static final UserRepositoryImpl _instance = UserRepositoryImpl._internal();

  factory UserRepositoryImpl() => _instance;

  UserRepositoryImpl._internal();

  User? user;

  static final User mockUser = User(
    firstName: "Test Implementation",
    lastName: "J",
    email: "test@test.com",
    birthDateInMillisFromEpoch: DateTime(2000, 1, 1).millisecondsSinceEpoch,
    adress: Adress(
      street: "test",
      city: "test",
      postalCode: "75000",
      country: "France",
    ),
  );

  @override
  User? getUser() {
    return user ?? mockUser;
  }

  @override
  void setUser(User user) {
    this.user = user;
  }

}