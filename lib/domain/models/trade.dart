class Trade {
  final String id;
  final String name;
  final String? description;
  final String? parentTradeId;

  const Trade({required this.id, required this.name, this.description, this.parentTradeId});
}
