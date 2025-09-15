import 'package:dwarka_app/features/tabs/home_tab/all_category_list.dart';
import 'package:dwarka_app/features/tabs/home_tab/product_screen.dart';
import 'package:dwarka_app/features/tabs/cart_tab/cart_screen.dart';
import 'package:dwarka_app/models/cart_item.dart';
import 'package:dwarka_app/providers/cart_provider.dart';
import 'package:dwarka_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../theme/theme_utils.dart';
import 'package:dwarka_app/models/product.dart' as model;
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 800;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

              /// Banner Carousel
              _BannerCarousel(),
              const SizedBox(height: 36),

              /// Categories
              Section(
                title: 'Categories',
                seeAll: true,
                child: CategoriesSection(isWide: isWide),
                onSeeAllPressed: () {
                  context.go('/categories');
                },
              ),
              const SizedBox(height: 36),

              /// Top Selling
              Section(
                title: 'Top Selling',
                seeAll: true,
                child: ProductList(
                  products: [
                    model.Product(
                      id: '1',
                      title: 'Product 1',
                      description: 'Description for Product 1',
                      images: ['assets/images/products/Product_1.png'],
                      price: 985.25,
                      crossPrice: 699.23,
                      reviews: [],
                      variants: [],
                      category: 'Top Selling',
                      rating: 4.5,
                    ),
                    model.Product(
                      id: '2',
                      title: 'Product 2',
                      description: 'Description for Product 2',
                      images: ['assets/images/products/product_2.png'],
                      price: 956.25,
                      crossPrice: 799.23,
                      reviews: [],
                      variants: [],
                      category: 'Top Selling',
                      rating: 4.2,
                    ),
                    model.Product(
                      id: '3',
                      title: 'Product 3',
                      description: 'Description for Product 3',
                      images: ['assets/images/products/product_3.png'],
                      price: 856.25,
                      crossPrice: 699.23,
                      reviews: [],
                      variants: [],
                      category: 'Top Selling',
                      rating: 4.0,
                    ),
                    model.Product(
                      id: '4',
                      title: 'Product 4',
                      description: 'Description for Product 4',
                      images: ['assets/images/products/product_4.png'],
                      price: 756.25,
                      crossPrice: 799.23,
                      reviews: [],
                      variants: [],
                      category: 'Top Selling',
                      rating: 3.8,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),

              /// New In
              Section(
                title: 'New In',
                seeAll: true,
                child: ProductList(
                  products: [
                    model.Product(
                      id: '5',
                      title: 'Product 5',
                      description: 'Description for Product 5',
                      images: ['assets/images/products/Product_1.png'],
                      price: 768.25,
                      crossPrice: 929.23,
                      reviews: [],
                      variants: [],
                      category: 'New In',
                      rating: 4.7,
                    ),
                    model.Product(
                      id: '6',
                      title: 'Product 6',
                      description: 'Description for Product 6',
                      images: ['assets/images/products/product_2.png'],
                      price: 856.25,
                      crossPrice: 799.23,
                      reviews: [],
                      variants: [],
                      category: 'New In',
                      rating: 4.3,
                    ),
                    model.Product(
                      id: '4',
                      title: 'Product 4',
                      description: 'Description for Product 4',
                      images: ['assets/images/products/product_3.png'],
                      price: 956.25,
                      crossPrice: 799.23,
                      reviews: [],
                      variants: [],
                      category: 'New In',
                      rating: 4.1,
                    ),
                    model.Product(
                      id: '7',
                      title: 'Product 7',
                      description: 'Description for Product 7',
                      images: ['assets/images/products/product_4.png'],
                      price: 756.25,
                      crossPrice: 799.23,
                      reviews: [],
                      variants: [],
                      category: 'New In',
                      rating: 3.9,
                    ),
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

/// ================= BANNER CAROUSEL =================
class _BannerCarousel extends StatefulWidget {
  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> bannerImages = [
    'assets/images/dwarka_logo.jpg',
    'assets/images/products/Product_1.png',
    'assets/images/products/product_2.png',
    'assets/images/products/product_3.png',
  ];

  @override
  void initState() {
    super.initState();
    // Auto-scroll if there are multiple banners
    if (bannerImages.length > 1) {
      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && bannerImages.length > 1) {
        final nextPage = (_currentPage + 1) % bannerImages.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            itemCount: bannerImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: textFieldBackgroundColor(context),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    bannerImages[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: textFieldBackgroundColor(context),
                        child: const Icon(Icons.error_outline, size: 40),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        if (bannerImages.length > 1) ...[
          const SizedBox(height: 16),
          SmoothPageIndicator(
            controller: _pageController,
            count: bannerImages.length,
            effect: ScrollingDotsEffect(
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
              dotHeight: 8,
              dotWidth: 8,
              spacing: 6,
            ),
          ),
        ],
      ],
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
            items: <String>['Sai Nagar', 'Rajapeth', 'Amravati']
                .map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
            hint: const Text('Location'),
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push('/cart');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Iconsax.bag_2,
                          color: Colors.white, size: 22),
                    ),
                  ),
                  if (cartProvider.itemCount > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          cartProvider.itemCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
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
        color: textFieldPlaceholderColor(context),
        fontSize: 14,
      ),
      prefix: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Icon(Iconsax.search_normal_1, size: 20),
      ),
      decoration: BoxDecoration(
        color: textFieldBackgroundColor(context),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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

  const Section({
    super.key,
    required this.title,
    required this.seeAll,
    required this.child,
    this.onSeeAllPressed,
  });

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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isWide ? 22 : 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (seeAll)
              GestureDetector(
                onTap: onSeeAllPressed,
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
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
      CategoryItem(
        imagePath: 'assets/images/categories/men_pic.png',
        label: 'Mens',
        onTap: () {
          context.push('/category/mens');
        },
      ),
      CategoryItem(
        imagePath: 'assets/images/categories/women_pic.png',
        label: 'Womens',
        onTap: () {
          context.push('/category/womens');
        },
      ),
      CategoryItem(
        imagePath: 'assets/images/categories/kid_pic.png',
        label: 'Kids',
        onTap: () {
          context.push('/category/kid');
        },
      ),
      CategoryItem(
        imagePath: 'assets/images/categories/men_pic.png',
        label: 'New Arrivals',
        onTap: () {
          context.push('/category/new-arrivals');
        },
      ),
      CategoryItem(
        imagePath: 'assets/images/categories/men_pic.png',
        label: 'On Sale!',
        onTap: () {
          context.push('/category/sale');
        },
      ),
      CategoryItem(
        imagePath: 'assets/images/categories/men_pic.png',
        label: 'Lens/accessories',
        onTap: () {
          context.push('/category/accessories');
        },
      ),
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
              width:
              MediaQuery.of(context).size.width / 3, // 👈 3 items visible
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
  const CategoryItem({
  super.key,
  required this.imagePath,     required this.label,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 85,
        margin: const EdgeInsets.only(right: 14),
        child: Column(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: textFieldBackgroundColor(context),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  imagePath,
                  height: 65,
                  width: 65,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

/// ================= PRODUCTS =================

///================= Home Page Products(Product List) =================
class ProductList extends StatelessWidget {
  final List<model.Product> products;
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
          childAspectRatio: 0.9, // 👈 balanced so cards aren't too tall/wide
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            imagePath: product.images.isNotEmpty ? product.images[0] : '',
            title: product.title,
            price: product.price.toString(),
            crossPrice: product.crossPrice.toString(),
            cardWidth: cardWidth,
            onTap: () {
              context.push('/product/${product.id}');
            },
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
              imagePath: product.images.isNotEmpty ? product.images[0] : '',
              title: product.title,
              price: product.price.toString(),
              crossPrice: product.crossPrice.toString(),
              onTap: () {
                context.push('/product/${product.id}');
              },
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
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.crossPrice,
    required this.cardWidth,
    this.onTap,
  });

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
              color: Colors.black.withOpacity(0.05),
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
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Add to cart functionality
                          final cartItem = CartItem(
                            id: '${title}_${DateTime.now().millisecondsSinceEpoch}',
                            title: title,
                            imagePath: imagePath,
                            price: double.parse(
                                price.replaceAll('₹', '').replaceAll(',', '')),
                            originalPrice: double.parse(crossPrice
                                .replaceAll('₹', '')
                                .replaceAll(',', '')),
                            quantity: 1,
                          );
                          context.read<CartProvider>().addItem(cartItem);

                          // Show success snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$title added to cart'),
                              backgroundColor: primaryColor,
                              duration: const Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Iconsax.box_add),
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
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
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
                          color: TextFieldTextColor.withOpacity(0.5),
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