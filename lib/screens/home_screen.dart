import 'package:flutter/material.dart';

import '../models/user_role.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  final User user;

  const HomeScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        actions: [
          // زر البروفايل
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // الانتقال إلى صفحة البروفايل
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: user),
                ),
              );
            },
          ),
        ],
      ),
      // يمكنك إضافة محتوى الشاشة الرئيسية هنا
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // صورة المستخدم مع اسمه
            GestureDetector(
              onTap: () {
                // الانتقال إلى صفحة البروفايل عند الضغط على الصورة
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: user),
                  ),
                );
              },
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      user.name[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'مرحباً، ${user.name}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.role.arabicName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
