import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../models/user_role.dart';
import '../widgets/shadcn/button.dart';
import '../widgets/shadcn/card.dart' as shadcn;
import '../widgets/shadcn/input.dart';
import 'admin_dashboard_screen.dart';
import 'company_dashboard_screen.dart';
import 'imam_dashboard_screen.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);
    final isPasswordVisible = useState(false);
    final selectedRole = useState<UserRole>(UserRole.imam);

    void navigateBasedOnRole(User user) {
      if (!context.mounted) return;

      Widget targetScreen;
      switch (user.role) {
        case UserRole.imam:
          targetScreen = ImamDashboardScreen(user: user);
          break;
        case UserRole.admin:
          targetScreen = AdminDashboardScreen(user: user);
          break;
        case UserRole.company:
          targetScreen = CompanyDashboardScreen(user: user);
          break;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => targetScreen,
        ),
      );
    }

    void handleLogin() async {
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('الرجاء إدخال اسم المستخدم وكلمة المرور'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      isLoading.value = true;
      // Simulate API call and get user data
      await Future.delayed(const Duration(seconds: 2));

      final mockUser = User(
        id: '1',
        name: usernameController.text,
        email: '${usernameController.text}@example.com',
        role: selectedRole.value,
      );

      isLoading.value = false;
      navigateBasedOnRole(mockUser);
    }

    Widget buildRoleButton(UserRole role, String label, IconData icon) {
      final isSelected = selectedRole.value == role;
      return Expanded(
        child: GestureDetector(
          onTap: () => selectedRole.value = role,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).dividerColor,
              ),
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.mosque,
                    size: 60,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 32),

                // Title
                Text(
                  'نظام صيانة المساجد',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Mosque Maintenance System',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 48),

                // Login Form
                shadcn.Card(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Role Selection
                      Text(
                        'اختر نوع الحساب',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          buildRoleButton(
                            UserRole.imam,
                            'إمام/موظف',
                            Icons.person_outline,
                          ),
                          const SizedBox(width: 12),
                          buildRoleButton(
                            UserRole.admin,
                            'مشرف',
                            Icons.admin_panel_settings_outlined,
                          ),
                          const SizedBox(width: 12),
                          buildRoleButton(
                            UserRole.company,
                            'صيانة',
                            Icons.business_outlined,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Input(
                        controller: usernameController,
                        label: 'اسم المستخدم',
                        hint: 'أدخل اسم المستخدم أو البريد الإلكتروني',
                        prefix: const Icon(Icons.person_outline),
                        textDirection: TextDirection.rtl,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16),
                      Input(
                        controller: passwordController,
                        label: 'كلمة المرور',
                        hint: 'أدخل كلمة المرور',
                        obscureText: !isPasswordVisible.value,
                        prefix: const Icon(Icons.lock_outline),
                        suffix: IconButton(
                          icon: Icon(
                            isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            isPasswordVisible.value = !isPasswordVisible.value;
                          },
                        ),
                        textDirection: TextDirection.rtl,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => handleLogin(),
                      ),
                      const SizedBox(height: 24),
                      Button(
                        onPressed: isLoading.value ? null : handleLogin,
                        isLoading: isLoading.value,
                        size: ButtonSize.lg,
                        child: const Text('تسجيل الدخول'),
                      ),
                      const SizedBox(height: 16),
                      Button(
                        variant: ButtonVariant.ghost,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('سيتم تنفيذ هذه الخاصية قريباً'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                        child: const Text('نسيت كلمة المرور؟'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
