import 'package:flutter/material.dart';

import '../widgets/shadcn/button.dart';
import '../widgets/shadcn/card.dart' as shadcn;
import '../widgets/shadcn/input.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for requests
    final requests = [
      {
        'title': 'صيانة مكيف',
        'mosque': 'مسجد النور',
        'status': 'في انتظار الموافقة',
        'priority': 'عالي',
        'date': '2024-03-20',
        'company': 'شركة الصيانة المتحدة',
        'cost': '1500 ريال',
      },
      {
        'title': 'إصلاح سباكة',
        'mosque': 'مسجد التقوى',
        'status': 'قيد التنفيذ',
        'priority': 'متوسط',
        'date': '2024-03-19',
        'company': 'شركة الخدمات الفنية',
        'cost': '800 ريال',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('الطلبات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement add new request
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
                  Input(
                    hint: 'البحث في الطلبات...',
                    prefix: const Icon(Icons.search),
                    onChanged: (value) {
                      // TODO: Implement search
                    },
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
                            Icon(Icons.filter_list, size: 16),
                            SizedBox(width: 4),
                            Text('الحالة'),
                          ],
                        ),
                      ),
                      Button(
                        onPressed: () {},
                        variant: ButtonVariant.outline,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.priority_high, size: 16),
                            SizedBox(width: 4),
                            Text('الأولوية'),
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
                            Icon(Icons.date_range, size: 16),
                            SizedBox(width: 4),
                            Text('التاريخ'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Overview
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'إجمالي الطلبات',
                    value: '45',
                    icon: Icons.assignment,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'في الانتظار',
                    value: '12',
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Requests List
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
                      Navigator.pushNamed(context, '/request-details',
                          arguments: request);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    request['title']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    request['mosque']!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            _buildStatusChip(request['status']!),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildPriorityChip(request['priority']!),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                request['company']!,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Text(
                              request['date']!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              request['cost']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Row(
                              children: [
                                Button(
                                  onPressed: () {},
                                  variant: ButtonVariant.outline,
                                  size: ButtonSize.sm,
                                  child: const Text('تفاصيل'),
                                ),
                                const SizedBox(width: 8),
                                Button(
                                  onPressed: () {},
                                  size: ButtonSize.sm,
                                  child: const Text('موافقة'),
                                ),
                              ],
                            ),
                          ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add new request
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
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
      case 'في انتظار الموافقة':
        color = Colors.orange;
        break;
      case 'قيد التنفيذ':
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
      case 'عالي':
        color = Colors.red;
        break;
      case 'متوسط':
        color = Colors.orange;
        break;
      case 'منخفض':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
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
