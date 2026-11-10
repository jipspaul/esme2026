import 'package:esme26/data/repositories/portfolio_project_repository_impl.dart';
import 'package:esme26/domain/repositories/portfolio_project_repository.dart' as domain;

abstract class PortfolioProjectRepository implements domain.PortfolioProjectRepository {
  static final PortfolioProjectRepository instance = PortfolioProjectRepositoryImpl();
}
