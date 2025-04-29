import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../widgets/shadcn/button.dart' as shadcn;
import '../widgets/shadcn/card.dart' as shadcn;
import 'login_screen.dart';

class CompanyDashboardScreen extends StatelessWidget {
  final User? user;

  const CompanyDashboardScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الشركة'),
        leading: IconButton(
          icon: const Icon(Icons.logout_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile', arguments: user);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Welcome Section
          shadcn.Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      user?.name.substring(0, 1).toUpperCase() ?? 'C',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مرحباً، ${user?.name ?? "شركة الصيانة"}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Text('مرحباً بك في لوحة تحكم الشركة'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: shadcn.Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'طلبات الصيانة النشطة',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '12',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: shadcn.Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'طلبات مكتملة',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '48',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Recent Maintenance Requests
          shadcn.Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'طلبات الصيانة الحديثة',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('طلب صيانة #${1000 + index}'),
                        subtitle: Text('مسجد ${index + 1}'),
                        trailing: _buildStatusChip(context, index % 3),
                        onTap: () {
                          // Navigate to maintenance request details
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: shadcn.Button(
        variant: shadcn.ButtonVariant.primary,
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text('إضافة تقرير صيانة'),
          ],
        ),
        onPressed: () {
          // Navigate to create maintenance report
        },
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, int status) {
    final statuses = [
      {'label': 'جديد', 'color': Colors.blue as Color},
      {'label': 'قيد التنفيذ', 'color': Colors.orange as Color},
      {'label': 'مكتمل', 'color': Colors.green as Color},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (statuses[status]['color'] as Color).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        statuses[status]['label'] as String,
        style: TextStyle(
          color: statuses[status]['color'] as Color,
          fontSize: 12,
        ),
      ),
    );
  }
}
