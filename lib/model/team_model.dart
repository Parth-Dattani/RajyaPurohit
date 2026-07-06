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

class PastPresident {
  final int srNo;
  final String name;
  final String duration;
  final String years;
  final String? imageUrl;

  PastPresident({
    required this.srNo,
    required this.name,
    required this.duration,
    required this.years,
    this.imageUrl,
  });
}
