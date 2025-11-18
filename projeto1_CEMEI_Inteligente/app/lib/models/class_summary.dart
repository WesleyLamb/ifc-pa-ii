import 'package:app/models/class_base.dart';

class ClassSummary extends ClassBase {
  const ClassSummary({
    required super.id,
    required super.name,
    required super.createdAt,
    required super.updatedAt,
    required super.active,
  });

  factory ClassSummary.fromJson(Map<String, dynamic> json) {
    return ClassSummary(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      active: json['active'] as bool,
    );
  }
}
