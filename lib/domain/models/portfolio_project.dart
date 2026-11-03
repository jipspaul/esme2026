import 'package:esme26/domain/models/attachment.dart';

class PortfolioProject {
  final String id;
  final String artisanId;
  final String title;
  final String description;
  final Set<String> tradeIds;
  final List<Attachment> media;
  final DateTime? completedAt;
  final String? city;

  PortfolioProject({
    required this.id,
    required this.artisanId,
    required this.title,
    required this.description,
    required Set<String> tradeIds,
    List<Attachment> media = const [],
    this.completedAt,
    this.city,
  }) : tradeIds = Set.unmodifiable(tradeIds),
       media = List.unmodifiable(media);
}
