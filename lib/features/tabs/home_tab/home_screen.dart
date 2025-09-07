import 'package:dwarka_app/features/tabs/home_tab/all_category_list.dart';
import 'package:dwarka_app/features/tabs/home_tab/category_details.dart';
import 'package:dwarka_app/features/tabs/home_tab/product_screen.dart';
import 'package:dwarka_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 40 : 16,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderRow(),
              const SizedBox(height: 28),
              const SearchBar(),
              const SizedBox(height: 36),

              /// Categories
              Section(
                title: 'Categories',
                seeAll: true,
                child: CategoriesSection(isWide: isWide),
                onSeeAllPressed:(){
                  Navigator.push(context,CupertinoPageRoute(builder:(context)=>AllCategoryList(),
                  ));
                },
              ),
              const SizedBox(height: 36),

              /// Top Selling
              const Section(
                title: 'Top Selling',
                seeAll: true,
                child: ProductList(
                  products: const [
                    Product(
                        title: 'Product 1',
                        price: '\₹985.25',
                        imagePath: 'assets/images/products/Product_1.png',
                        crossPrice: '\₹699.23'),
                    Product(
                        title: 'Product 2',
                        price: '\₹956.25',
                        imagePath: 'assets/images/products/product_2.png',
                        crossPrice: '\₹799.23'),
                    Product(
                        title: 'Product 3',
                        price: '\₹856.25',
                        imagePath: 'assets/images/products/product_3.png',
                        crossPrice: '\₹699.23'),
                    Product(
                        title: 'Product 4',
                        price: '\₹756.25',
                        imagePath: 'assets/images/products/product_4.png',
                        crossPrice: '\₹799.23'),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              /// New In
              const Section(
                title: 'New In',
                seeAll: true,
                child: ProductList(
                  products: const [
                    Product(
                        title: 'Product 5',
                        price: '\₹768.25',
                        imagePath: 'assets/images/products/Product_1.png',
                        crossPrice: '\₹929.23'),
                    Product(
                        title: 'Product 6',
                        price: '\₹856.25',
                        imagePath: 'assets/images/products/product_2.png',
                        crossPrice: '\₹799.23'),
                    Product(
                        title: 'Product 4',
                        price: '\₹956.25',
                        imagePath: 'assets/images/products/product_3.png',
                        crossPrice: '\₹799.23'),
                    Product(
                        title: 'Product 7',
                        price: '\₹756.25',
                        imagePath: 'assets/images/products/product_4.png',
                        crossPrice: '\₹799.23'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ================= HEADER =================
class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 10 : 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage('assets/images/profile_img.png'),
          ),
          DropdownButton<String>(
            underline: const SizedBox(),
            items: <String>['Services 1', 'Services 2', 'Services 3']
                .map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
            hint: const Text('Location'),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(Iconsax.bag_2, color: Colors.white, size: 22),
          )
        ],
      ),
    );
  }
}

/// ================= SEARCH BAR =================
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      placeholder: 'Search Products...',
      placeholderStyle: TextStyle(
        color: TextFieldTextColor.withValues(alpha: 0.5),
        fontSize: 14,
      ),
      prefix: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Icon(Iconsax.search_normal_1, size: 20),
      ),
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}

/// ================= SECTION TITLE =================
class Section extends StatelessWidget {
  final String title;
  final bool seeAll;
  final Widget child;
  final VoidCallback? onSeeAllPressed;

  const Section(
      {super.key,
        required this.title,
        required this.seeAll,
        required this.child,
        this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isWide ? 22 : 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (seeAll)
              GestureDetector (
                onTap:onSeeAllPressed ,
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

/// ================= CATEGORIES =================
class CategoriesSection extends StatelessWidget {
  final bool isWide;
  const CategoriesSection({super.key, required this.isWide});

  @override
  Widget build(BuildContext context) {
    final categories = [
      CategoryItem(imagePath: 'assets/images/categories/men_pic.png', label: 'Mens',onTap:(){
        Navigator.push(context, CupertinoPageRoute(builder: (context) =>CategoryDetails(),));
      },
      ),
      CategoryItem(imagePath: 'assets/images/categories/women_pic.png', label: 'Womens'),
      CategoryItem(imagePath: 'assets/images/categories/kid_pic.png', label: 'Kids'),
      CategoryItem(imagePath: 'assets/images/categories/men_pic.png', label: 'New Arrivals'),
      CategoryItem(imagePath: 'assets/images/categories/men_pic.png', label: 'On Sale!'),
      CategoryItem(imagePath: 'assets/images/categories/men_pic.png', label: 'Lens/accessories'),
    ];

    if (isWide) {
      /// On wide screens → Horizontal scroll (3 items visible)
      return SizedBox(
        height: 150, // Adjust height if needed
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 3, // 👈 3 items visible
              child: categories[index],
            );
          },
        ),
      );
    } else {
      /// On mobile → Horizontal scroll (default)
      return SizedBox(
        height: 110,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: categories,
        ),
      );
    }
  }
}


class CategoryItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;
  const CategoryItem({super.key, required this.imagePath, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        margin: const EdgeInsets.only(right: 14),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                imagePath,
                height: 65,
                width: 65,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

/// ================= PRODUCTS =================
class Product {
  final String imagePath;
  final String title;
  final String price;
  final String crossPrice;
  const Product(
      {required this.title,
        required this.price,
        required this.imagePath,
        required this.crossPrice});
}
///================= Home Page Products(Product List) =================
class ProductList extends StatelessWidget {

  final List<Product> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 800;

    final cardWidth = isWide
        ? 180.0
        : width > 600
        ? 160.0
        : 130.0;

    if (isWide) {
      /// Grid layout on wide screens
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: width > 1400
              ? 5
              : width > 1100
              ? 4
              : 3, // 👈 adapt grid count by screen size
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.9, // 👈 balanced so cards aren’t too tall/wide
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            imagePath: product.imagePath,
            title: product.title,
            price: product.price,
            crossPrice: product.crossPrice,
            cardWidth: cardWidth,
          );
        },
      );
    } else {
      /// Horizontal list on mobile
      return SizedBox(
        height: width < 400 ? 220 : 260, // smaller height for small mobiles
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              imagePath: product.imagePath,
              title: product.title,
              price: product.price,
              crossPrice: product.crossPrice,
              onTap:(){
                Navigator.push(context,CupertinoPageRoute(builder: (context) => ProductScreen(),
                ));
              } ,

              cardWidth: width < 400 ? 140.0 : 150.0, // reduced width
            );
          },
        ),
      );
    }
  }
}


class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String crossPrice;
  final double cardWidth;
  final VoidCallback?onTap;
  const ProductCard(
      {super.key,
        required this.imagePath,
        required this.title,
        required this.price,
        required this.crossPrice,
        required this.cardWidth, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.heart),
                        color: Colors.black87,
                        iconSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: TextFieldTextColor.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        crossPrice,
                        style: TextStyle(
                          color: TextFieldTextColor.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
