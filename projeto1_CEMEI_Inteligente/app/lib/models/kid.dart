class Kid {
  final String id;
  final String libraryIdentifier;
  final String name;
  late DateTime birthday;
  final String cpf;
  final String turn;
  final List<dynamic> classes;
  final bool active;

  Kid(
    this.id,
    this.libraryIdentifier,
    this.name,
    String birthdayStr,
    this.cpf,
    this.turn,
    this.classes,
    this.active,
  ) {
    birthday = DateTime.parse(birthdayStr);
  }

  // Factory constructor para criar Kid a partir de JSON
  factory Kid.fromJson(Map<String, dynamic> json) {
    return Kid(
      json['id'],
      json['library_identifier'],
      json['name'],
      json['birthday'],
      json['cpf'],
      json['turn'],
      json['classes'],
      json['active'] ?? true,
    );
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
