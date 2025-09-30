class Driver {
  final String name;
  final String status; // e.g., "Available", "On Delivery"
  final String description;
  final bool hasAvatar;

  Driver({
    required this.name,
    required this.status,
    required this.description,
    this.hasAvatar = false,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      name: json['name'],
      status: json['status'],
      description: json['description'],
      hasAvatar: json['hasAvatar'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'description': description,
      'hasAvatar': hasAvatar,
    };
  }
}
