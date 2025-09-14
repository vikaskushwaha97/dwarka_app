import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import 'package:go_router/go_router.dart'; // Add this import

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.favorite_border,
            title: 'Wishlist',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.location_on_outlined,
            title: 'Addresses',
            onTap: () {
              context.push('/profile/addresses');
            },
          ),
          _ProfileTile(
            icon: Icons.visibility_outlined,
            title: 'Eye Prescription',
            onTap: () {},
          ),
          const SizedBox(height: 24),

// Support Section
          Text('Support', style: AppStyles.titleLarge),
          const SizedBox(height: 16),
          _ProfileTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.info_outline,
            title: 'About Us',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.phone_outlined,
            title: 'Contact Us',
            onTap: () {},
          ),
          const SizedBox(height: 24),

// Legal Section
          Text('Legal', style: AppStyles.titleLarge),
          const SizedBox(height: 16),
          _ProfileTile(
            icon: Icons.security_outlined,
            title: 'Privacy Policy',
            onTap: () {},
          ),
          _ProfileTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: AppStyles.bodyLarge),
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}