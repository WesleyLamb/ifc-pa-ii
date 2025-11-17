import 'package:app/models/class_summary.dart';

class KidBase {
  final String id;
  final String libraryIdentifier;
  final String name;
  final DateTime birthday;
  final String cpf;
  final String turn;
  final ClassSummary? cemeiClass;
  final bool active;

  const KidBase({
    required this.id,
    required this.libraryIdentifier,
    required this.name,
    required this.birthday,
    required this.cpf,
    required this.turn,
    required this.cemeiClass,
    required this.active,
  });

  // Calcular idade
  int get idade {
    final agora = DateTime.now();
    int idade = agora.year - birthday.year;
    if (agora.month < birthday.month ||
        (agora.month == birthday.month && agora.day < birthday.day)) {
      idade--;
    }
    return idade;
  }

  int get idadeEmMeses {
    final agora = DateTime.now();
    int meses =
        (agora.year - birthday.year) * 12 + (agora.month - birthday.month);
    if (agora.day < birthday.day) {
      meses--;
    }
    return meses;
  }

  // Formatar turno
  String get turnoFormatado {
    switch (turn.toLowerCase()) {
      case 'matutino':
        return 'Manhã';
      case 'vespertino':
        return 'Tarde';
      case 'integral':
        return 'Integral';
      default:
        return turn;
    }
  }

  // Obter iniciais do nome
  String get iniciais {
    final partes = name.trim().split(' ');
    if (partes.isEmpty) return '?';
    if (partes.length == 1) return partes[0][0].toUpperCase();
    return '${partes[0][0]}${partes[partes.length - 1][0]}'.toUpperCase();
  }
}
