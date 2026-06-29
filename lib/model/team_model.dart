class TeamMember {
  final String name;
  final String role;
  final String phone;
  final String? imageUrl;

  TeamMember({
    required this.name,
    required this.role,
    required this.phone,
    this.imageUrl,
  });
}