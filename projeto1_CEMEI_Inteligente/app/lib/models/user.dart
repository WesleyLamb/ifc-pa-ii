class User {
  final String id;
  final String email;
  final String name;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> permissions;

  User(
    this.id,
    this.email,
    this.name,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.permissions,
  );

  static User fromJson(Map<String, dynamic> json) {
    DateTime? emailVerifiedAt = json['email_verified_at'] != null
        ? DateTime.parse(json['email_verified_at'])
        : null;
    DateTime? createdAt = DateTime.parse(json['created_at']);
    DateTime? updatedAt = DateTime.parse(json['updated_at']);
    List<String> permissions = List.from(json['permissions']);

    return User(
      json['id'],
      json['email'],
      json['name'],
      emailVerifiedAt,
      createdAt,
      updatedAt,
      permissions,
    );
  }
}
