class MaintenanceRequest {
  final String id;
  final String title;
  final String location;
  final String category;
  final String priority;
  final String description;
  final DateTime createdAt;
  final String status;

  MaintenanceRequest({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.priority,
    required this.description,
    required this.createdAt,
    this.status = 'pending',
  });

  MaintenanceRequest copyWith({
    String? title,
    String? location,
    String? category,
    String? priority,
    String? description,
    String? status,
  }) {
    return MaintenanceRequest(
      id: id,
      title: title ?? this.title,
      location: location ?? this.location,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      description: description ?? this.description,
      createdAt: createdAt,
      status: status ?? this.status,
    );
  }
}
