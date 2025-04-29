import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/maintenance_provider.dart';
import 'screens/admin_dashboard_screen.dart';
import 'screens/companies_management_screen.dart';
import 'screens/company_dashboard_screen.dart';
import 'screens/imam_dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/users_management_screen.dart';
import 'theme/shadcn_theme.dart';

void main() {
  runApp(const MosqueMaintenanceApp());
}

class MosqueMaintenanceApp extends StatelessWidget {
  const MosqueMaintenanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MaintenanceProvider(),
      child: MaterialApp(
        title: 'Mosque Management',
        debugShowCheckedModeBanner: false,
        theme: ShadTheme.lightTheme,
        locale: const Locale('ar', 'SA'), // Default to Arabic
        supportedLocales: const [
          Locale('ar', 'SA'), // Arabic
          Locale('en', 'US'), // English
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/admin-dashboard': (context) =>
              const AdminDashboardScreen(user: null),
          '/imam-dashboard': (context) => const ImamDashboardScreen(user: null),
          '/company-dashboard': (context) =>
              const CompanyDashboardScreen(user: null),
          '/users-management': (context) => const UsersManagementScreen(),
          '/companies-management': (context) =>
              const CompaniesManagementScreen(),
          '/reports': (context) => const ReportsScreen(),
        },
      ),
    );
  }
}
