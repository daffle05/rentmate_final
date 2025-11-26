import 'package:flutter/material.dart';
import '/features/dashboard/presentation/screens/dashboard_screen.dart';
import '/presentation/tenant/screens/tenant_list_screen.dart';
import '/presentation/screens/all_payments_screen.dart';
import '/shared/themes/theme.dart';

/// Placeholder for Offline Storage info screen
class OfflineStoragePlaceholder extends StatelessWidget {
  const OfflineStoragePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Storage')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.storage, size: 64, color: Colors.blue),
              SizedBox(height: 16),
              Text(
                'Offline Storage',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'All tenant and payment data is automatically saved to local storage.\n\n'
                'Your data is always available, even without internet connection.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RootNavigationScreen extends StatefulWidget {
  const RootNavigationScreen({super.key});

  @override
  State<RootNavigationScreen> createState() => _RootNavigationScreenState();
}

class _RootNavigationScreenState extends State<RootNavigationScreen> {
  int _selectedIndex = 0;

  // List of screens corresponding to each bottom nav item
  late final List<Widget> _screens = [
    const DashboardScreen(),         // Index 0: Dashboard
    const TenantListScreen(),        // Index 1: Tenant Management
    const AllPaymentsScreen(),       // Index 2: Payments
    const OfflineStoragePlaceholder(), // Index 3: Offline Storage (placeholder)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Tenants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Storage',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
