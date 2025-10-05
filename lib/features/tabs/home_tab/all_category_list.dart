import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/theme_utils.dart';

class AllCategoryList extends StatelessWidget {
  const AllCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        title: const Text(
          'Shop By Categories',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back to Home (replace with your actual home route)
            context.go('/home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            CategoryItemList(
              imagePath: 'assets/images/categories/men_pic.png',
              label: 'Mens',
              route: '/category/mens',
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/women_pic.png',
              label: 'Womens',
              route: '/category/womens',
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/kid_pic.png',
              label: 'Kids',
              route: '/category/kid',
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/men_pic.png',
              label: 'Accessories',
              route: '/category/accessories',
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/men_pic.png',
              label: 'On Sale!',
              route: '/category/sale',
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/men_pic.png',
              label: 'Others',
              route: '/category/other',
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItemList extends StatelessWidget {
  final String imagePath;
  final String label;
  final String route;

  const CategoryItemList({
    super.key,
    required this.imagePath,
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: textFieldBackgroundColor(context),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                imagePath,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
