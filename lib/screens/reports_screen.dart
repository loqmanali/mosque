import 'package:flutter/material.dart';

import '../widgets/shadcn/button.dart';
import '../widgets/shadcn/card.dart' as shadcn;
import '../widgets/shadcn/input.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقارير'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implement filter
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // TODO: Implement export
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Date Range Selection
            shadcn.Card(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نطاق التقرير',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Expanded(
                        child: Input(
                          label: 'من تاريخ',
                          hint: 'اختر التاريخ',
                          prefix: Icon(Icons.calendar_today),
                          // onTap: () {
                          //   // TODO: Show date picker
                          // },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Input(
                          label: 'إلى تاريخ',
                          hint: 'اختر التاريخ',
                          prefix: Icon(Icons.calendar_today),
                          // onTap: () {
                          //   // TODO: Show date picker
                          // },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Button(
                      onPressed: () {
                        // TODO: Generate report
                      },
                      child: const Text('توليد التقرير'),
                    ),
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
                    value: '156',
                    icon: Icons.assignment,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'التكلفة الإجمالية',
                    value: '45,000 ريال',
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'متوسط وقت المعالجة',
                    value: '3.5 يوم',
                    icon: Icons.timer,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'نسبة الإنجاز',
                    value: '94%',
                    icon: Icons.trending_up,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Report Categories
            Text(
              'تقارير مخصصة',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildReportCard(
                  context,
                  title: 'تقرير الطلبات',
                  description: 'تحليل تفصيلي للطلبات وحالاتها',
                  icon: Icons.assignment_outlined,
                  color: Colors.blue,
                ),
                _buildReportCard(
                  context,
                  title: 'تقرير المساجد',
                  description: 'إحصائيات الصيانة حسب المساجد',
                  icon: Icons.mosque,
                  color: Colors.green,
                ),
                _buildReportCard(
                  context,
                  title: 'تقرير الشركات',
                  description: 'أداء وتقييم الشركات',
                  icon: Icons.business,
                  color: Colors.orange,
                ),
                _buildReportCard(
                  context,
                  title: 'تقرير المالية',
                  description: 'التكاليف والمصروفات',
                  icon: Icons.attach_money,
                  color: Colors.purple,
                ),
              ],
            ),
          ],
        ),
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

  Widget _buildReportCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return shadcn.Card(
      onTap: () {
        // TODO: Navigate to specific report
      },
      child: Padding(
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
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
