import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../services/auth_services.dart';
import '../../theme/theme_provider.dart';

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
                context.go('/landing'); // ✅ matches main.dart
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
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile_img.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Guest User',
                    style: AppStyles.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'guest@example.com',
                    style: AppStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/signin');
                    },
                    child: const Text('Sign In'),
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
            onTap: () => context.push('/profile/orders'),
          ),
          _ProfileTile(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () => context.push('/profile/wishlist'),
          ),
          _ProfileTile(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            onTap: () => context.push('/profile/addresses'),
          ),
          _ProfileTile(
            icon: Icons.visibility_outlined,
            title: 'Eye Prescription',
            onTap: () => context.push('/profile/prescription'), // ✅ nested under /profile
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
            onTap: () => context.push('/profile/help'),
          ),
          _ProfileTile(
            icon: Icons.info_outline,
            title: 'About Us',
            onTap: () => context.push('/profile/about'),
          ),
          _ProfileTile(
            icon: Icons.phone_outlined,
            title: 'Contact Us',
            onTap: () => context.push('/profile/contact'),
          ),
          const SizedBox(height: 24),

          // Legal Section
          Text('Legal', style: AppStyles.titleLarge),
          const SizedBox(height: 16),
          _ProfileTile(
            icon: Icons.security_outlined,
            title: 'Privacy Policy',
            onTap: () => context.push('/profile/privacy'),
          ),
          _ProfileTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () => context.push('/profile/terms'),
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
