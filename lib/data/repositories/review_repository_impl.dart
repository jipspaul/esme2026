import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/review_repository.dart';
import 'package:esme26/domain/models/review.dart';

class ReviewRepositoryImpl extends InMemoryRepository<Review, String> implements ReviewRepository {
  static final ReviewRepositoryImpl _instance = ReviewRepositoryImpl._internal();
  factory ReviewRepositoryImpl() => _instance;
  ReviewRepositoryImpl._internal() : super(MockData.reviews, keyOf: (item) => requireRepositoryId(item.id));
}
