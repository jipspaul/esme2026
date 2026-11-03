import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/app_notification_repository.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/domain/models/app_notification.dart';

class AppNotificationRepositoryImpl
    extends InMemoryRepository<AppNotification, String>
    implements AppNotificationRepository {
  static final AppNotificationRepositoryImpl _instance =
      AppNotificationRepositoryImpl._internal();
  factory AppNotificationRepositoryImpl() => _instance;
  AppNotificationRepositoryImpl._internal()
    : super(
        MockData.appNotifications,
        keyOf: (item) => requireRepositoryId(item.id),
      );
}
