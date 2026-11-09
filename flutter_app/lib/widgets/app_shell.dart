import 'package:flutter/material.dart';

class AppShell extends StatefulWidget {
  const AppShell({required this.pages, super.key});

  final List<Widget> pages;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _destinations = [
    _AppDestination('Overview', Icons.space_dashboard_outlined),
    _AppDestination('Shipments', Icons.local_shipping_outlined),
    _AppDestination('Analytics', Icons.insert_chart_outlined),
    _AppDestination('More', Icons.grid_view_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 900;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.public_rounded, color: Colors.white, size: 21),
            ),
            const SizedBox(width: 11),
            const Text(
              'GDP Logistics',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 20),
            child: CircleAvatar(
              radius: 17,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                'GP',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _selectDestination,
              labelType: NavigationRailLabelType.all,
              backgroundColor: Colors.white,
              destinations: _destinations
                  .map(
                    (destination) => NavigationRailDestination(
                      icon: Icon(destination.icon),
                      label: Text(destination.label),
                    ),
                  )
                  .toList(),
            ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: widget.pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _selectDestination,
              destinations: _destinations
                  .map(
                    (destination) => NavigationDestination(
                      icon: Icon(destination.icon),
                      label: destination.label,
                    ),
                  )
                  .toList(),
            ),
    );
  }

  void _selectDestination(int index) {
    setState(() => _selectedIndex = index);
  }
}

class _AppDestination {
  const _AppDestination(this.label, this.icon);

  final String label;
  final IconData icon;
}
