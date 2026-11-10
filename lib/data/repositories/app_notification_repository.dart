import 'package:esme26/data/repositories/app_notification_repository_impl.dart';
import 'package:esme26/domain/repositories/app_notification_repository.dart' as domain;

abstract class AppNotificationRepository implements domain.AppNotificationRepository {
  static final AppNotificationRepository instance = AppNotificationRepositoryImpl();
}
