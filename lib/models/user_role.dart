enum UserRole {
  imam,
  admin,
  company;

  String get arabicName {
    switch (this) {
      case UserRole.imam:
        return 'إمام';
      case UserRole.admin:
        return 'مشرف';
      case UserRole.company:
        return 'شركة صيانة';
    }
  }

  List<String> get permissions {
    switch (this) {
      case UserRole.imam:
        return [
          'view_requests',
          'create_request',
          'view_own_requests',
          'update_own_profile',
        ];
      case UserRole.admin:
        return [
          'view_all_requests',
          'manage_requests',
          'manage_users',
          'manage_companies',
          'view_reports',
          'manage_settings',
        ];
      case UserRole.company:
        return [
          'view_assigned_requests',
          'update_request_status',
          'add_request_notes',
          'upload_documents',
          'update_company_profile',
        ];
    }
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? mosqueId; // For imams
  final String? companyId; // For company representatives

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.mosqueId,
    this.companyId,
  });

  bool hasPermission(String permission) {
    return role.permissions.contains(permission);
  }
}
