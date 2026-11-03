import 'package:esme26/data/repositories/review_repository_impl.dart';
import 'package:esme26/domain/repositories/review_repository.dart' as domain;

abstract class ReviewRepository implements domain.ReviewRepository {
  static final ReviewRepository instance = ReviewRepositoryImpl();
}
