class Class {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool active;

  Class({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.active,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      active: json['active'] ?? true,
    );
  }
}
