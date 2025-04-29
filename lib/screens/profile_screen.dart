import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.primary,
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user.role.arabicName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'الصلاحيات المتاحة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: user.role.permissions.length,
                    itemBuilder: (context, index) {
                      final permission = user.role.permissions[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: const Icon(
                            Icons.check_circle,
                            color: AppTheme.success,
                          ),
                          title: Text(_getArabicPermissionName(permission)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getArabicPermissionName(String permission) {
    // ترجمة الصلاحيات إلى العربية
    switch (permission) {
      case 'view_requests':
        return 'عرض الطلبات';
      case 'create_request':
        return 'إنشاء طلب جديد';
      case 'view_own_requests':
        return 'عرض طلباتي';
      case 'update_own_profile':
        return 'تحديث الملف الشخصي';
      case 'view_all_requests':
        return 'عرض جميع الطلبات';
      case 'manage_requests':
        return 'إدارة الطلبات';
      case 'manage_users':
        return 'إدارة المستخدمين';
      case 'manage_companies':
        return 'إدارة الشركات';
      case 'view_reports':
        return 'عرض التقارير';
      case 'manage_settings':
        return 'إدارة الإعدادات';
      case 'view_assigned_requests':
        return 'عرض الطلبات المسندة';
      case 'update_request_status':
        return 'تحديث حالة الطلب';
      case 'add_request_notes':
        return 'إضافة ملاحظات للطلب';
      case 'upload_documents':
        return 'رفع المستندات';
      case 'update_company_profile':
        return 'تحديث ملف الشركة';
      default:
        return permission;
    }
  }
}
