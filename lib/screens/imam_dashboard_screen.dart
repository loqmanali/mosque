import 'package:flutter/material.dart';

import '../models/user_role.dart';
import '../widgets/shadcn/button.dart';
import '../widgets/shadcn/card.dart' as shadcn;
import 'login_screen.dart';
import 'maintenance_request_screen_ar.dart';
import 'profile_screen.dart';
import 'request_details_screen.dart';

class ImamDashboardScreen extends StatelessWidget {
  final User? user;

  const ImamDashboardScreen({Key? key, this.user}) : super(key: key);

  // void _showSearchDialog(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     transitionAnimationController: AnimationController(
  //       duration: const Duration(milliseconds: 400),
  //       vsync: Navigator.of(context),
  //     ),
  //     builder: (BuildContext context) {
  //       return AnimatedContainer(
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeInOut,
  //         decoration: const BoxDecoration(
  //           color: Color(0xFF0A0A0A),
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           ),
  //         ),
  //         child: Directionality(
  //           textDirection: TextDirection.rtl,
  //           child: Padding(
  //             padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom,
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Handle bar for bottom sheet
  //                 Container(
  //                   margin: const EdgeInsets.only(top: 8),
  //                   width: 40,
  //                   height: 4,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey[600],
  //                     borderRadius: BorderRadius.circular(2),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Row(
  //                     children: [
  //                       const Text(
  //                         'بحث الطلبات',
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       IconButton(
  //                         icon: const Icon(Icons.close, color: Colors.white),
  //                         onPressed: () => Navigator.pop(context),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: 16.0, vertical: 8.0),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       color: const Color(0xFF1A1A1A),
  //                       borderRadius: BorderRadius.circular(12),
  //                       border: Border.all(
  //                         color: Colors.grey[800]!,
  //                         width: 1,
  //                       ),
  //                     ),
  //                     padding: const EdgeInsets.symmetric(horizontal: 16),
  //                     child: Row(
  //                       children: [
  //                         const Icon(Icons.search, color: Colors.grey),
  //                         const SizedBox(width: 8),
  //                         Expanded(
  //                           child: TextField(
  //                             textDirection: TextDirection.rtl,
  //                             style: const TextStyle(color: Colors.white),
  //                             decoration: const InputDecoration(
  //                               hintText: 'ادخل كلمة للبحث',
  //                               hintStyle: TextStyle(color: Colors.grey),
  //                               border: InputBorder.none,
  //                             ),
  //                             autofocus: true,
  //                             onChanged: (value) {
  //                               // Implement search functionality here
  //                             },
  //                           ),
  //                         ),
  //                         IconButton(
  //                           icon: const Icon(Icons.close, color: Colors.grey),
  //                           onPressed: () {
  //                             // Clear search text
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 16),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
                              const MaintenanceRequestScreenAr(),
                        ),
                      );
                    },
                    size: ButtonSize.sm,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلبات الصيانة',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                // TextButton(
                //   onPressed: () {
                //     // Navigate to maintenance requests list
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const ImamMaintenanceDashboard(),
                //       ),
                //     );
                //   },
                //   child: const Text('عرض الكل'),
                // ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            request['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildPriorityBadge(request['priority'] as String),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              request['location'] as String,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          request['description'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestDetailsScreen(
                            request: request,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color;
    switch (priority) {
      case 'عالية':
        color = Colors.red;
        break;
      case 'متوسطة':
        color = Colors.orange;
        break;
      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
