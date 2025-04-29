import 'package:flutter/material.dart';

import '../widgets/shadcn/button.dart';
import '../widgets/shadcn/card.dart' as shadcn;
import '../widgets/shadcn/input.dart';

class UsersManagementScreen extends StatelessWidget {
  const UsersManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for users
    final users = [
      {
        'name': 'أحمد محمد',
        'email': 'ahmed@example.com',
        'role': 'إمام',
        'mosque': 'مسجد النور',
        'status': 'نشط',
      },
      {
        'name': 'محمد علي',
        'email': 'mohamed@example.com',
        'role': 'شركة',
        'company': 'شركة الصيانة المتحدة',
        'status': 'نشط',
      },
      {
        'name': 'عمر أحمد',
        'email': 'omar@example.com',
        'role': 'إمام',
        'mosque': 'مسجد التقوى',
        'status': 'معلق',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المستخدمين'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Search and Filter Section
            shadcn.Card(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Input(
                    hint: 'البحث عن مستخدمين...',
                    prefix: Icon(Icons.search),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Button(
                        onPressed: () {},
                        variant: ButtonVariant.outline,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person, size: 16),
                            SizedBox(width: 4),
                            Text('نوع المستخدم'),
                          ],
                        ),
                      ),
                      Button(
                        onPressed: () {},
                        variant: ButtonVariant.outline,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.mosque, size: 16),
                            SizedBox(width: 4),
                            Text('المسجد'),
                          ],
                        ),
                      ),
                      Button(
                        onPressed: () {},
                        variant: ButtonVariant.outline,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.business, size: 16),
                            SizedBox(width: 4),
                            Text('الشركة'),
                          ],
                        ),
                      ),
                      Button(
                        onPressed: () {},
                        variant: ButtonVariant.outline,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle, size: 16),
                            SizedBox(width: 4),
                            Text('الحالة'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'إجمالي المستخدمين',
                    value: '156',
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'الأئمة',
                    value: '120',
                    icon: Icons.mosque,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'الشركات',
                    value: '36',
                    icon: Icons.business,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Users List Header
            Row(
              children: [
                Text(
                  'المستخدمين',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Button(
                  onPressed: () {
                    // TODO: Show add user dialog
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text('إضافة مستخدم'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Users List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: shadcn.Card(
                    onTap: () {
                      // TODO: Navigate to user details
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                child: Text(
                                  user['name']![0],
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
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
                                      user['name']!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      user['email']!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              _buildStatusChip(user['status']!),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              _buildRoleChip(user['role']!),
                              const SizedBox(width: 8),
                              if (user['mosque'] != null)
                                Expanded(
                                  child: Text(
                                    user['mosque']!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                              else if (user['company'] != null)
                                Expanded(
                                  child: Text(
                                    user['company']!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              Row(
                                children: [
                                  Button(
                                    onPressed: () {
                                      // TODO: Show edit dialog
                                    },
                                    variant: ButtonVariant.outline,
                                    size: ButtonSize.sm,
                                    child: const Text('تعديل'),
                                  ),
                                  const SizedBox(width: 8),
                                  Button(
                                    onPressed: () {
                                      // TODO: Show deactivate confirmation
                                    },
                                    variant: ButtonVariant.destructive,
                                    size: ButtonSize.sm,
                                    child: const Text('تعطيل'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Show add user dialog
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return shadcn.Card(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'نشط':
        color = Colors.green;
        break;
      case 'معلق':
        color = Colors.orange;
        break;
      case 'معطل':
        color = Colors.red;
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

  Widget _buildRoleChip(String role) {
    Color color;
    IconData icon;
    switch (role) {
      case 'إمام':
        color = Colors.green;
        icon = Icons.mosque;
        break;
      case 'شركة':
        color = Colors.blue;
        icon = Icons.business;
        break;
      case 'مشرف':
        color = Colors.purple;
        icon = Icons.admin_panel_settings;
        break;
      default:
        color = Colors.grey;
        icon = Icons.person;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            role,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
