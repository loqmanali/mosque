import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../widgets/shadcn/button.dart';
import '../widgets/shadcn/card.dart' as shadcn;
import 'maintenance_request_screen.dart';
import 'profile_screen.dart';
import 'request_details_screen.dart';

class ImamDashboardScreen extends StatelessWidget {
  final User? user;

  const ImamDashboardScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for maintenance requests
    final requests = [
      {
        'title': 'صيانة مكيف المسجد',
        'status': 'قيد الانتظار',
        'date': '2024-03-20',
        'priority': 'عالية',
        'category': 'تكييف',
        'location': 'قاعة الصلاة الرئيسية',
        'description': 'المكيف يصدر صوتاً مزعجاً ولا يبرد بشكل جيد',
      },
      {
        'title': 'إصلاح إضاءة المحراب',
        'status': 'جاري العمل',
        'date': '2024-03-19',
        'priority': 'متوسطة',
        'category': 'كهرباء',
        'location': 'المحراب',
        'description': 'الإضاءة تنطفئ بشكل متكرر وتحتاج إلى صيانة',
      },
      {
        'title': 'صيانة نظام الصوت',
        'status': 'مكتمل',
        'date': '2024-03-18',
        'priority': 'منخفضة',
        'category': 'صوتيات',
        'location': 'غرفة التحكم',
        'description': 'مكبرات الصوت تصدر صدى وتحتاج إلى ضبط',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الإمام'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: user!),
                ),
              );
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Welcome Section
            shadcn.Card(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text(
                          user!.name[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مرحباً بك،',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              user!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Button(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MaintenanceRequestScreen(),
                        ),
                      );
                    },
                    size: ButtonSize.lg,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 8),
                        Text('طلب صيانة جديد'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Requests Section
            Text(
              'طلبات الصيانة',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: shadcn.Card(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RequestDetailsScreen(request: request),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request['title']!,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildStatusChip(request['status']!),
                            const SizedBox(width: 8),
                            _buildPriorityChip(request['priority']!),
                            const Spacer(),
                            Text(
                              request['date']!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          request['description']!,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'قيد الانتظار':
        color = Colors.orange;
        break;
      case 'جاري العمل':
        color = Colors.blue;
        break;
      case 'مكتمل':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority) {
    Color color;
    switch (priority) {
      case 'عالية':
        color = Colors.red;
        break;
      case 'متوسطة':
        color = Colors.orange;
        break;
      case 'منخفضة':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
