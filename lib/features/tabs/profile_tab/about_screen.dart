import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Try multiple navigation methods to ensure we can go back
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/profile');
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.info_outline,
                size: 64,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'About Dwarka Eyewear',
              style: AppStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your Vision is Our Mission',
              style: AppStyles.titleMedium.copyWith(
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'Who We Are',
              style: AppStyles.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Dwarka Eyewear is a premium eyewear brand dedicated to providing high-quality, stylish glasses and sunglasses at affordable prices. With years of experience in the optical industry, we combine fashion with function to bring you the perfect pair of glasses.',
              style: AppStyles.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Our Mission',
              style: AppStyles.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'To help people see better and look better by offering a wide selection of eyewear that meets the highest standards of quality, style, and comfort. We believe everyone deserves access to affordable vision care without compromising on style.',
              style: AppStyles.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Why Choose Us',
              style: AppStyles.titleLarge,
            ),
            const SizedBox(height: 8),
            _buildFeatureItem('Premium Quality Materials'),
            _buildFeatureItem('Latest Fashion Trends'),
            _buildFeatureItem('Prescription Accuracy Guaranteed'),
            _buildFeatureItem('30-Day Return Policy'),
            _buildFeatureItem('Free Adjustments & Repairs'),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Try multiple navigation methods to ensure we can go back
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/profile');
                  }
                },
                child: const Text('Back to Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.primary,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppStyles.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}