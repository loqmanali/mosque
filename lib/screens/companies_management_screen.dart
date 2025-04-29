import 'package:flutter/material.dart';

import '../widgets/shadcn/button.dart';
import '../widgets/shadcn/card.dart' as shadcn;
import '../widgets/shadcn/input.dart';

class CompaniesManagementScreen extends StatelessWidget {
  const CompaniesManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for companies
    final companies = [
      {
        'name': 'شركة الصيانة المتحدة',
        'email': 'info@united-maintenance.com',
        'phone': '0512345678',
        'address': 'الرياض - حي النزهة',
        'specialties': ['تكييف', 'كهرباء', 'سباكة'],
        'status': 'نشط',
        'completedRequests': '45',
        'activeRequests': '8',
        'rating': '4.8',
      },
      {
        'name': 'شركة الخدمات الفنية',
        'email': 'info@technical-services.com',
        'phone': '0598765432',
        'address': 'جدة - حي الصفا',
        'specialties': ['سباكة', 'نظافة', 'صيانة عامة'],
        'status': 'نشط',
        'completedRequests': '32',
        'activeRequests': '5',
        'rating': '4.5',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الشركات'),
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
                    hint: 'البحث عن شركات...',
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
                            Icon(Icons.handyman, size: 16),
                            SizedBox(width: 4),
                            Text('التخصص'),
                          ],
                        ),
                      ),
                      Button(
                        onPressed: () {},
                        variant: ButtonVariant.outline,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on, size: 16),
                            SizedBox(width: 4),
                            Text('المنطقة'),
                          ],
                        ),
                      ),
                      Button(
                        onPressed: () {},
                        variant: ButtonVariant.outline,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 16),
                            SizedBox(width: 4),
                            Text('التقييم'),
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
                    title: 'إجمالي الشركات',
                    value: '36',
                    icon: Icons.business,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'الطلبات النشطة',
                    value: '128',
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'طلبات مكتملة',
                    value: '1,450',
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Companies List Header
            Row(
              children: [
                Text(
                  'الشركات',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Button(
                  onPressed: () {
                    // TODO: Show add company dialog
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text('إضافة شركة'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Companies List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: shadcn.Card(
                    onTap: () {
                      // TODO: Navigate to company details
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                child: Icon(
                                  Icons.business,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      company['name'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      company['email'] as String,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              _buildStatusChip(company['status'] as String),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                company['phone'] as String,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(width: 16),
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  company['address'] as String,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final specialty
                                  in company['specialties'] as List<String>)
                                _buildSpecialtyChip(specialty),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    company['rating'] as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'طلبات نشطة: ${company['activeRequests']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      Text(
                                        'طلبات مكتملة: ${company['completedRequests']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),
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
          // TODO: Show add company dialog
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

  Widget _buildSpecialtyChip(String specialty) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        specialty,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
