import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatefulWidget {
  final String productId;

  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _selectedImageIndex = 0;
  int _quantity = 1;
  String _selectedSize = 'M';
  String _selectedLens = 'Blue Light';
  Color _selectedLensColor = Colors.blue;

  final List<String> _productImages = [
    'assets/images/products/sunglasses_1.png',
    'assets/images/products/sunglasses_2.png',
    'assets/images/products/sunglasses_3.png',
    'assets/images/products/sunglasses_4.png',
  ];

  final List<Map<String, dynamic>> _sizes = [
    {'label': 'S', 'value': 'S'},
    {'label': 'M', 'value': 'M'},
    {'label': 'L', 'value': 'L'},
    {'label': 'XL', 'value': 'XL'},
  ];

  final List<Map<String, dynamic>> _lensOptions = [
    {'name': 'Blue Light', 'color': Colors.blue},
    {'name': 'Photochromic', 'color': Colors.purple},
    {'name': 'Polarized', 'color': Colors.green},
    {'name': 'Progressive', 'color': Colors.orange},
  ];

  final List<Map<String, dynamic>> _reviews = [
    {
      'user': 'Rahul Sharma',
      'rating': 4.5,
      'comment': 'Very comfortable and stylish. The blue light protection really helps with my eye strain during long working hours.',
      'date': '2 days ago',
      'avatar': 'assets/images/avatars/user1.jpg'
    },
    {
      'user': 'Priya Patel',
      'rating': 5.0,
      'comment': 'Absolutely love these! They fit perfectly and the lens quality is exceptional. Would definitely recommend.',
      'date': '1 week ago',
      'avatar': 'assets/images/avatars/user2.jpg'
    },
    {
      'user': 'Amit Kumar',
      'rating': 4.0,
      'comment': 'Good product for the price. The frame is sturdy and the lenses are scratch-resistant as advertised.',
      'date': '2 weeks ago',
      'avatar': 'assets/images/avatars/user3.jpg'
    },
  ];

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _addToCart() {
    // Add product to cart logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to cart successfully!'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => context.push('/cart'),
        ),
      ),
    );
  }

  void _buyNow() {
    // Navigate to checkout
    context.push('/checkout');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Iconsax.heart),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Images with Thumbnails
                  _buildImageSection(),

                  // Product Info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Premium Aviator Sunglasses',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '₹2,499',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '₹3,499',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '29% OFF',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Rating and Reviews
                        Row(
                          children: [
                            _buildRatingStars(4.5),
                            const SizedBox(width: 8),
                            Text(
                              '4.5 (213 Reviews)',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Size Selection
                        Text(
                          'Select Size',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildSizeOptions(),
                        const SizedBox(height: 24),

                        // Lens Type Selection
                        Text(
                          'Lens Type',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildLensOptions(),
                        const SizedBox(height: 24),

                        // Quantity Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantity',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: _decrementQuantity,
                                  ),
                                  SizedBox(
                                    width: 30,
                                    child: Center(
                                      child: Text(
                                        _quantity.toString(),
                                        style: theme.textTheme.titleMedium,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: _incrementQuantity,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Product Description
                        Text(
                          'Description',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Premium quality aviator sunglasses with UV400 protection. '
                              'Features polarized lenses that reduce glare and improve visual clarity. '
                              'The frames are made from high-grade acetate for durability and comfort.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Reviews Section
                        Text(
                          'Customer Reviews',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildReviewsList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomBar(),
    );
  }

  Widget _buildImageSection() {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: _productImages.length,
            onPageChanged: (index) {
              setState(() {
                _selectedImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                _productImages[index],
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _productImages.length,
                (index) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selectedImageIndex == index
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _productImages.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImageIndex = index;
                  });
                },
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedImageIndex == index
                          ? Colors.blue
                          : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      _productImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSizeOptions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _sizes.map((size) {
        final isSelected = _selectedSize == size['value'];
        return ChoiceChip(
          label: Text(size['label']),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedSize = size['value'];
            });
          },
          selectedColor: Colors.blue,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : null,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLensOptions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: _lensOptions.map((lens) {
        final isSelected = _selectedLens == lens['name'];
        return FilterChip(
          label: Text(lens['name']),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedLens = lens['name'];
              _selectedLensColor = lens['color'];
            });
          },
          selectedColor: Colors.blue,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : null,
          ),
          avatar: CircleAvatar(
            backgroundColor: lens['color'],
            radius: 8,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 20);
        } else if (index == rating.floor() && rating % 1 > 0) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 20);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 20);
        }
      }),
    );
  }

  Widget _buildReviewsList() {
    return Column(
      children: _reviews.map((review) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(review['avatar']),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['user'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildRatingStars(review['rating']),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    review['date'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                review['comment'],
                style: TextStyle(
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Wishlist button
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Iconsax.heart),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 12),
            // Add to cart button
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Add to Cart'),
                onPressed: _addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Buy now button
            Expanded(
              child: ElevatedButton(
                onPressed: _buyNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}