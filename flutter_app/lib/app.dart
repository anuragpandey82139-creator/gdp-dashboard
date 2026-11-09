import 'package:flutter/material.dart';

import 'screens/dashboard_screen.dart';
import 'screens/placeholder_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/app_shell.dart';

class GdpLogisticsApp extends StatelessWidget {
  const GdpLogisticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDP Logistics',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: AppShell(
        pages: const [
          DashboardScreen(),
          PlaceholderScreen(
            title: 'Shipments',
            icon: Icons.local_shipping_outlined,
            description:
                'Shipment tracking will live here. Connect a data source to replace this starter view.',
          ),
          PlaceholderScreen(
            title: 'Analytics',
            icon: Icons.insert_chart_outlined,
            description:
                'Explore GDP trends and operational performance here as the dashboard grows.',
          ),
          PlaceholderScreen(
            title: 'More',
            icon: Icons.grid_view_rounded,
            description: 'Inventory, suppliers, fleet, and settings can be added here.',
          ),
        ],
      ),
    );
  }
}
