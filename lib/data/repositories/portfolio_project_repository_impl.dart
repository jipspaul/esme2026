import 'package:esme26/data/mocks/mock_data.dart';
import 'package:esme26/data/repositories/in_memory_repository.dart';
import 'package:esme26/data/repositories/portfolio_project_repository.dart';
import 'package:esme26/domain/models/portfolio_project.dart';

class PortfolioProjectRepositoryImpl
    extends InMemoryRepository<PortfolioProject, String>
    implements PortfolioProjectRepository {
  static final PortfolioProjectRepositoryImpl _instance =
      PortfolioProjectRepositoryImpl._internal();
  factory PortfolioProjectRepositoryImpl() => _instance;
  PortfolioProjectRepositoryImpl._internal()
    : super(
        MockData.portfolioProjects,
        keyOf: (item) => requireRepositoryId(item.id),
      );
}
