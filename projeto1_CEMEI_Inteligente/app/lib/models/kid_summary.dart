import 'package:app/models/class_summary.dart';
import 'package:app/models/kid_base.dart';

class KidSummary extends KidBase {
  const KidSummary({
    required super.id,
    required super.libraryIdentifier,
    required super.name,
    required super.birthday,
    required super.cpf,
    required super.turn,
    required super.cemeiClass,
    required super.active,
  });

  factory KidSummary.fromJson(Map<String, dynamic> json) {
    return KidSummary(
      id: json['id'],
      libraryIdentifier: json['library_identifier'],
      name: json['name'],
      birthday: DateTime.parse(json['birthday']),
      cpf: json['cpf'],
      turn: json['turn'],
      cemeiClass: json['class'] != null
          ? ClassSummary.fromJson(json['class'])
          : null,
      active: json['active'] as bool,
    );
  }
}
