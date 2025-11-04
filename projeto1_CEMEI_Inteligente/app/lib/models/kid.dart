class Kid {
  final String id;
  final String libraryIdentifier;
  final String name;
  late DateTime birthday;
  final String cpf;
  final String turn;
  final bool active;

  Kid(
    this.id,
    this.libraryIdentifier,
    this.name,
    String birthdayStr,
    this.cpf,
    this.turn,
    this.active,
  ) {
    birthday = DateTime.parse(birthdayStr);
  }
}
