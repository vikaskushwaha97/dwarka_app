import 'package:dwarka_app/features/tabs/home_tab/home_screen.dart';
import 'package:dwarka_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  CategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text(
          'Mens(240)',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, right: 5, bottom: 20, left: 20),
        child: ProductList(
          products: [
            Product(
              title: 'Product 1',
              price: '\₹856.25',
              imagePath: 'assets/images/products/Product_1.png',
              crossPrice: '\₹799.23',
            ),
            Product(
              title: 'Product 2',
              price: '\₹956.25',
              imagePath: 'assets/images/products/product_2.png',
              crossPrice: '\₹919.23',
            ),
            Product(
              title: 'Product 3',
              price: '\₹856.25',
              imagePath: 'assets/images/products/product_3.png',
              crossPrice: '\₹799.23',
            ),
            Product(
              title: 'Product 4',
              price: '\₹656.25',
              imagePath: 'assets/images/products/product_4.png',
              crossPrice: '\₹899.23',
            ),
            Product(
              title: 'Product 1',
              price: '\₹956.25',
              imagePath: 'assets/images/products/Product_1.png',
              crossPrice: '\₹899.23',
            ),
            Product(
              title: 'Product 2',
              price: '\₹756.25',
              imagePath: 'assets/images/products/product_2.png',
              crossPrice: '\₹959.23',
            ),
            Product(
              title: 'Product 3',
              price: '\₹756.25',
              imagePath: 'assets/images/products/product_3.png',
              crossPrice: '\₹799.23',
            ),
            Product(
              title: 'Product 4',
              price: '\₹856.25',
              imagePath: 'assets/images/products/product_4.png',
              crossPrice: '\₹699.23',
            ),
            Product(
              title: 'Product 2',
              price: '\₹756.25',
              imagePath: 'assets/images/products/product_2.png',
              crossPrice: '\₹599.23',
            ),
            Product(
              title: 'Product 3',
              price: '\₹756.25',
              imagePath: 'assets/images/products/product_3.png',
              crossPrice: '\₹999.23',
            ),
            Product(
              title: 'Product 4',
              price: '\₹656.25',
              imagePath: 'assets/images/products/product_4.png',
              crossPrice: '\₹899.23',
            ),
          ],
        ),
      ),
    );
  }
}
class ProductList extends StatelessWidget {
  final List<Product> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180, // ✅ compact grid like Amazon
        crossAxisSpacing: 8,     // tighter spacing
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,  // taller cards (image + title + price)
      ),
      itemCount: products.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          imagePath: product.imagePath,
          title: product.title,
          price: product.price,
          crossPrice: product.crossPrice,
          cardWidth: width < 400
              ? 135.0   // small phones (denser look)
              : width < 800
              ? 150.0   // tablets
              : 170.0,  // desktops
        );
      },
    );
  }
}
