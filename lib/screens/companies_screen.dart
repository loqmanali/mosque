import 'package:flutter/material.dart';

import '../widgets/shadcn/button.dart';
import '../widgets/shadcn/card.dart' as shadcn;
import '../widgets/shadcn/input.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for companies
    final companies = [
      {
        'name': 'شركة الصيانة المتحدة',
        'type': 'صيانة عامة',
        'rating': '4.8',
        'completedProjects': '156',
        'status': 'نشط',
        'location': 'الرياض',
        'contact': '0512345678',
      },
      {
        'name': 'شركة الخدمات الفنية',
        'type': 'كهرباء وتكييف',
        'rating': '4.5',
        'completedProjects': '98',
        'status': 'نشط',
        'location': 'جدة',
        'contact': '0598765432',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('الشركات'),
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
              // TODO: Implement add new company
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
                    hint: 'البحث عن شركة...',
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
                            Icon(Icons.category, size: 16),
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
                            Text('الموقع'),
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
                    title: 'إجمالي الشركات',
                    value: '18',
                    icon: Icons.business,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'المشاريع المنجزة',
                    value: '254',
                    icon: Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.business,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    company['name']!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    company['type']!,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            _buildStatusChip(company['status']!),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip(
                              context,
                              icon: Icons.star,
                              label: company['rating']!,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              context,
                              icon: Icons.check_circle,
                              label: '${company['completedProjects']} مشروع',
                              color: Colors.green,
                            ),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                              context,
                              icon: Icons.location_on,
                              label: company['location']!,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              company['contact']!,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const Spacer(),
                            Button(
                              onPressed: () {},
                              variant: ButtonVariant.outline,
                              size: ButtonSize.sm,
                              child: const Text('تفاصيل'),
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
          // TODO: Implement add new company
        },
        child: const Icon(Icons.add_business),
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
      case 'نشط':
        color = Colors.green;
        break;
      case 'غير نشط':
        color = Colors.grey;
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

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
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
            label,
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
