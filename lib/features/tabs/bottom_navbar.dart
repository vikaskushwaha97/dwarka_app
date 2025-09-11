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
    const Placeholder(),
    Container(),
    const ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.home_2,
              size: 32,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.notification_bing,
              size: 32,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.receipt_2_1,
              size: 32,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Iconsax.profile_add,
              size: 32,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        backgroundColor: Theme.of(context).colorScheme.surface,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}