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
        title: Text(
          'Shop By Categories',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            CategoryItemList(
              imagePath: 'assets/images/categories/men_pic.png',
              label: 'Mens',
              onTap: () {
                context.push('/category/mens');
              },
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/women_pic.png',
              label: 'Womens',
              onTap: () {
                context.push('/category/womens');
              },
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/kid_pic.png',
              label: 'Kid',
              onTap: () {
                context.push('/category/kid');
              },
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/men_pic.png',
              label: 'Accessories',
              onTap: () {
                context.push('/category/accessories');
              },
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/men_pic.png',
              label: 'onSale!',
              onTap: () {
                context.push('/category/sale');
              },
            ),
            CategoryItemList(
              imagePath: 'assets/images/categories/men_pic.png',
              label: '....',
              onTap: () {
                context.push('/category/other');
              },
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
  final VoidCallback? onTap;

  const CategoryItemList({
    super.key,
    required this.imagePath,
    required this.label,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            const SizedBox(
              width: 10.0,
            ),
            Text(
              label,
              style: TextStyle(
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