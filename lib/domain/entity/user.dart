class User {
  final String id;
  final String username;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? universityName;
  final bool isActive;
  final String? role;

  const User(
    this.id,
    this.username,
    this.name,
    this.email,
    this.phoneNumber,
    this.universityName,
    this.isActive,
    this.role
  );
}
