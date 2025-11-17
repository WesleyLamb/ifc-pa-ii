import 'dart:developer' as developer;

class Kid {
  final String id;
  final String libraryIdentifier;
  final String name;
  late DateTime birthday;
  final String? father_name;
  final String? mother_name;
  final String cpf;
  final String turn;
  final List<dynamic> classes;
  final bool active;
  final String? classId;

  Kid(
    this.id,
    this.libraryIdentifier,
    this.name,
    String birthdayStr,
    this.father_name,
    this.mother_name,
    this.cpf,
    this.turn,
    this.classes,
    this.active,
    this.classId,
  ) {
    try {
      birthday = DateTime.parse(birthdayStr);
    } catch (e) {
      developer.log('Erro ao parsear data: $birthdayStr - $e', name: 'Kid');
      birthday = DateTime(2000, 1, 1); // Data padrão em caso de erro
    }
  }

  // Factory constructor para criar Kid a partir de JSON
  factory Kid.fromJson(Map<String, dynamic> json) {
    try {
      return Kid(
        json['id'] as String? ?? '',
        json['library_identifier'] as String? ?? '',
        json['name'] as String? ?? '',
        json['birthday'] as String? ?? '2000-01-01',
        json['father_name'] as String?,
        json['mother_name'] as String?,
        json['cpf'] as String? ?? '',
        json['turn'] as String? ?? 'Integral',
        json['classes'] as List<dynamic>? ?? [],
        json['active'] as bool? ?? true,
        json['class_id'] as String?,
      );
    } catch (e) {
      developer.log('Erro ao parsear Kid JSON: $json - $e', name: 'Kid');
      rethrow;
    }
  }

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
    int meses = (agora.year - birthday.year) * 12 + (agora.month - birthday.month);
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
