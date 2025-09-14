import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_provider.dart';
import '../../theme/theme_utils.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Profile Section
            Card(
              color: Theme.of(context).cardTheme.color,
              elevation: Theme.of(context).cardTheme.elevation,
              shape: Theme.of(context).cardTheme.shape,
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
                      'Vikas Kushwaha',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'vikas@gmail.com',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
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
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Account Section
            Text('Account', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _ProfileTile(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 8),
            _ProfileTile(
              icon: Icons.favorite_border,
              title: 'Wishlist',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 8),
            _ProfileTile(
              icon: Icons.location_on_outlined,
              title: 'Addresses',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 8),
            _ProfileTile(
              icon: Icons.visibility_outlined,
              title: 'Eye Prescription',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 24),
            _ProfileTile(
              icon: Icons.palette_outlined,
              title: 'App Theme',
              subtitle: _themeModeLabel(themeProvider.themeMode),
              onTap: () => _showThemeBottomSheet(context, themeProvider),
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 24),


            // Support Section
            Text('Support', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _ProfileTile(
              icon: Icons.help_outline,
              title: 'Help Center',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 8),
            _ProfileTile(
              icon: Icons.info_outline,
              title: 'About Us',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 8),
            _ProfileTile(
              icon: Icons.phone_outlined,
              title: 'Contact Us',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 24),

            // Legal Section
            Text('Legal', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _ProfileTile(
              icon: Icons.security_outlined,
              title: 'Privacy Policy',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 8),
            _ProfileTile(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              onTap: () {},
              backgroundColor: textFieldBackgroundColor(context),
            ),
            const SizedBox(height: 32),

            // Sign Out Button
            TextButton(
              onPressed: () {},
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
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color backgroundColor;

  const _ProfileTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: subtitle != null
            ? Text(
          subtitle!,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
          ),
        )
            : null,
        trailing: Icon(
          Iconsax.arrow_right_3,
          size: 18,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
        ),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

String _themeModeLabel(ThemeMode mode) {
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