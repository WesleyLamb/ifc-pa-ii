class ClassBase {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool active;

  const ClassBase({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.active,
  });
}
