import 'package:esme26/data/models/user.dart';
import 'package:esme26/data/models/adress.dart';
import 'package:esme26/data/repositories/user_repository.dart';

class UserRepositoryJP implements UserRepository {

  User? user;

  static final User mockUser = User(
    firstName: "JP",
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