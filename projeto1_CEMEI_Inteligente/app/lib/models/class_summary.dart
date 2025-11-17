class ClassSummary {
  final String id;
  final String name;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  // final bool active;

  const ClassSummary({
    required this.id,
    required this.name,
    // required this.createdAt,
    // required this.updatedAt,
    // required this.active,
  });

  factory ClassSummary.fromJson(Map<String, dynamic> json) {
    return ClassSummary(
      id: json['id'],
      name: json['name'],
      // createdAt: DateTime.parse(json['created_at']),
      // updatedAt: DateTime.parse(json['updated_at']),
      // active: json['active'] as bool,
    );
  }
}
