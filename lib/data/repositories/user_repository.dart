import 'package:esme26/data/models/user.dart';

class UserRepository {

  User? user;
  
  User? getUser() {
    return user;
  }

  void setUser(User user) {
    this.user = user;
  }

}