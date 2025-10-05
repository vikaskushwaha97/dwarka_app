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

  // Navigator keys for each tab - essential for nested navigation
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    // If same tab is tapped, pop to first route
    if (_selectedIndex == index) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  // Handle back button press
  Future<bool> _onWillPop() async {
    final currentNavigator = _navigatorKeys[_selectedIndex];

    // If current tab has routes in stack, pop one
    if (currentNavigator.currentState?.canPop() ?? false) {
      currentNavigator.currentState?.pop();
      return false; // Don't exit app
    }

    // If on other tab, switch to home tab
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false; // Don't exit app
    }

    return true; // Exit app if on home tab with no routes
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildNavigator(0, const HomeScreen()),
            _buildNavigator(1, const NotificationsScreen()),
            _buildNavigator(2, const TransactionsScreen()),
            _buildNavigator(3, const ProfileScreen()),
          ],
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

  Widget _buildNavigator(int index, Widget screen) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => screen,
        );
      },
    );
  }
}

// Placeholder screens
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