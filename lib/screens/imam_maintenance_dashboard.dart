import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/maintenance_provider.dart';

class ImamMaintenanceDashboard extends StatelessWidget {
  const ImamMaintenanceDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'طلبات الصيانة',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
        ),
        body: Consumer<MaintenanceProvider>(
          builder: (context, provider, child) {
            // final requests = provider.requests;

            // if (requests.isEmpty) {
            //   return const Center(
            //     child: Text('لا توجد طلبات صيانة حالياً'),
            //   );
            // }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: 3,
              itemBuilder: (context, index) {
                // final request = provider.requests[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'العنوان',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: 'عالية' == 'عالية'
                                ? Colors.red[100]
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'عالية',
                            style: TextStyle(
                              color: 'عالية' == 'عالية'
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text('الموقع'),
                        SizedBox(height: 4),
                        Text(
                          'تم الإنجاز',
                          style: TextStyle(
                            color: 'تم الإنجاز' == 'تم الإنجاز'
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
