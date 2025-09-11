import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../../utils/constant.dart';
import '../../theme/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/profile_img.png'),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1E1E1E)
                      : textFieldColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vikas Kushwaha',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'vikas@gmail.com',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
                              ),
                        ),
                        Text(
                          '7588970296',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
                              ),
                        ),
                      ],
                    ),
                    TextButton(onPressed: () {}, child: const Text('Edit'))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ProfileListTile(title: 'Address', pageRedirection: () {}),
              const SizedBox(height: 10),
              ProfileListTile(title: 'Wishlist', pageRedirection: () {}),
              const SizedBox(height: 10),
              ProfileListTile(title: 'Payment', pageRedirection: () {}),
              const SizedBox(height: 10),
              ProfileListTile(title: 'Help', pageRedirection: () {}),
              const SizedBox(height: 10),
              ProfileListTile(title: 'Support', pageRedirection: () {}),
              const SizedBox(height: 12),
              // App Theme selector tile → opens bottom sheet
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF1E1E1E)
                      : textFieldColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(
                    'App Theme',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    _themeModeLabel(themeProvider.themeMode),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: const Icon(Iconsax.arrow_right_3),
                  onTap: () => _showThemeBottomSheet(context, themeProvider),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
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

class ProfileListTile extends StatelessWidget {
  final String title;
  final VoidCallback pageRedirection;
  const ProfileListTile({super.key, required this.title, required this.pageRedirection});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E1E1E)
            : textFieldColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Iconsax.arrow_right_3),
        onTap: pageRedirection,
      ),
    );
  }
}
