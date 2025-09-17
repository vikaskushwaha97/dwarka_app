import 'package:dwarka_app/features/tabs/home_tab/home_screen.dart';
import 'package:dwarka_app/features/tabs/profile_tab/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationsScreen(),
    const TransactionsScreen(),
    const ProfileScreen(),
  ];

  // Track if we need to reset to home tab
  bool _shouldResetToHome = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _shouldResetToHome = false;
    });
  }

  // Handle back button press
  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false; // Don't exit app, just go to home tab
    }
    return true; // Exit app if already on home tab
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home_2, size: 24),
                activeIcon: Icon(Iconsax.home_25, size: 24),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.notification_bing, size: 24),
                activeIcon: Icon(Iconsax.notification_bing5, size: 24),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.receipt_2_1, size: 24),
                activeIcon: Icon(Iconsax.receipt_25, size: 24),
                label: 'Transactions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_add, size: 24),
                activeIcon: Icon(Iconsax.profile_add5, size: 24),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            backgroundColor: Theme.of(context).colorScheme.surface,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 8,
          ),
        ),
      ),
    );
  }
}

// Placeholder screens replaced with proper ones
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Notifications Screen'),
      ),
    );
  }
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Transactions Screen'),
      ),
    );
  }
}