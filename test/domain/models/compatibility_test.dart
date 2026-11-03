import 'package:esme26/data/models/adress.dart';
import 'package:esme26/data/models/user.dart';
import 'package:esme26/data/repositories/user_repository.dart';
import 'package:esme26/data/repositories/user_repository_JP.dart';
import 'package:esme26/data/repositories/user_repository_impl.dart';
import 'package:esme26/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    UserRepositoryJP().reset();
    UserRepositoryImpl().reset();
  });
  tearDown(() {
    UserRepositoryJP().reset();
    UserRepositoryImpl().reset();
  });

  test('UserRepositoryImpl returns the same instance', () {
    expect(UserRepositoryImpl(), same(UserRepositoryImpl()));
    expect(UserRepositoryJP(), same(UserRepositoryJP()));
    expect(UserRepository.instance, same(UserRepositoryJP()));
  });

  test('existing repositories can store and return domain users', () {
    final user = User(
      firstName: 'Test',
      lastName: 'Client',
      email: 'client@example.test',
      birthDateInMillisFromEpoch: DateTime.utc(2000).millisecondsSinceEpoch,
      adress: const Adress(
        street: '1 rue du Test',
        city: 'Paris',
        postalCode: '75001',
        country: 'France',
      ),
    );
    for (final repository in <UserRepository>[
      UserRepositoryJP(),
      UserRepositoryImpl(),
    ]) {
      expect(repository.getUser(), isA<User>());
      repository.setUser(user);
      expect(repository.getUser(), same(user));
    }
  });

  testWidgets('existing home screen still displays the repository user', (
    tester,
  ) async {
    final user = UserRepository.instance.getUser()!;
    await tester.pumpWidget(const MyApp());
    expect(find.text('Onboarding'), findsOneWidget);
    expect(
      find.text('User enrolled: ${user.firstName} ${user.lastName}'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
