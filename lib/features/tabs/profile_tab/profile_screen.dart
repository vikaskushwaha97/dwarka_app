import 'dart:io';

import 'package:dwarka_app/features/tabs/profile_tab/prescription_screen.dart';
import 'package:dwarka_app/features/tabs/profile_tab/privacy_screen.dart';
import 'package:dwarka_app/features/tabs/profile_tab/terms_screen.dart';
import 'package:dwarka_app/features/tabs/profile_tab/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../services/auth_services.dart';
import '../../../providers/user_provider.dart';
import '../../theme/theme_provider.dart';
import 'about_screen.dart';
import 'addresses_screen.dart';
import 'contact_screen.dart';
import 'edit_profile.dart';
import 'help_screen.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _signOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await AuthService.signOut();
                context.go('/landing');
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Profile Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: userProvider.profileImagePath != null
                        ? FileImage(File(userProvider.profileImagePath!)) as ImageProvider
                        : const AssetImage('assets/images/profile_img.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userProvider.name,
                    style: AppStyles.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userProvider.email,
                    style: AppStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                      );
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Account Section
          Text('Account', style: AppStyles.titleLarge),
          const SizedBox(height: 16),
          _ProfileTile(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersScreen()),
            ),
          ),
          _ProfileTile(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()),
            ),
          ),
          _ProfileTile(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddressesScreen()),
            ),
          ),
          _ProfileTile(
            icon: Icons.visibility_outlined,
            title: 'Eye Prescription',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrescriptionScreen()),
            ),
          ),

          const SizedBox(height: 24),

          // Preferences Section
          Text('Preferences', style: AppStyles.titleLarge),
          const SizedBox(height: 16),
          _ProfileTile(
            icon: Icons.palette_outlined,
            title: 'App Theme',
            subtitle: _themeModeLabel(themeProvider.themeMode),
            onTap: () => _showThemeBottomSheet(context, themeProvider),
          ),
          const SizedBox(height: 24),

          // Support Section
          Text('Support', style: AppStyles.titleLarge),
          const SizedBox(height: 16),
          _ProfileTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HelpScreen()),
            ),
          ),
          _ProfileTile(
            icon: Icons.info_outline,
            title: 'About Us',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutScreen()),
            ),
          ),
          _ProfileTile(
            icon: Icons.phone_outlined,
            title: 'Contact Us',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ContactScreen()),
            ),
          ),
          const SizedBox(height: 24),

          // Legal Section
          Text('Legal', style: AppStyles.titleLarge),
          const SizedBox(height: 16),
          _ProfileTile(
            icon: Icons.security_outlined,
            title: 'Privacy Policy',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrivacyScreen()),
            ),
          ),
          _ProfileTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsScreen()),
            ),
          ),
          const SizedBox(height: 32),

          // Sign Out Button
          TextButton(
            onPressed: () => _signOut(context),
            child: const Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _themeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light Theme';
      case ThemeMode.dark:
        return 'Dark Theme';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  void _showThemeBottomSheet(BuildContext context, ThemeProvider themeProvider) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Light Theme'),
              value: ThemeMode.light,
              groupValue: themeProvider.themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  themeProvider.setThemeMode(mode);
                  Navigator.pop(ctx);
                }
              },
            ),
            const Divider(height: 1),
            RadioListTile<ThemeMode>(
              title: const Text('Dark Theme'),
              value: ThemeMode.dark,
              groupValue: themeProvider.themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  themeProvider.setThemeMode(mode);
                  Navigator.pop(ctx);
                }
              },
            ),
            const Divider(height: 1),
            RadioListTile<ThemeMode>(
              title: const Text('System Default'),
              value: ThemeMode.system,
              groupValue: themeProvider.themeMode,
              onChanged: (mode) {
                if (mode != null) {
                  themeProvider.setThemeMode(mode);
                  Navigator.pop(ctx);
                }
              },
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppStyles.bodyLarge),
        subtitle: subtitle != null
            ? Text(
          subtitle!,
          style: AppStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        )
            : null,
        trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}