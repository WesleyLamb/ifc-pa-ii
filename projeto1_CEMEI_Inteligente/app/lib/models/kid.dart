import 'dart:developer' as developer;

import 'package:app/models/class_summary.dart';
import 'package:app/models/kid_base.dart';

class Kid extends KidBase {
  final String? fatherName;
  final String? motherName;

  Kid({
    required super.id,
    required super.libraryIdentifier,
    required super.name,
    required super.birthday,
    required this.fatherName,
    required this.motherName,
    required super.cpf,
    required super.turn,
    required super.cemeiClass,
    required super.active,
  });

  // Factory constructor para criar Kid a partir de JSON
  factory Kid.fromJson(Map<String, dynamic> json) {
    try {
      return Kid(
        id: json['id'],
        libraryIdentifier: json['library_identifier'],
        name: json['name'],
        birthday: DateTime.parse(json['birthday']),
        fatherName: json['father_name'],
        motherName: json['mother_name'],
        cpf: json['cpf'],
        turn: json['turn'],
        cemeiClass: json['class'] != null
            ? ClassSummary.fromJson(json['class'])
            : null,
        active: json['active'] as bool,
      );
    } catch (e) {
      developer.log('Erro ao parsear Kid JSON: $json - $e', name: 'Kid');
      rethrow;
    }
  }
}
