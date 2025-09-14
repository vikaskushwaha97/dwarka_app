import 'package:dwarka_app/features/tabs/home_tab/home_screen.dart';
import 'package:dwarka_app/models/product.dart' as model;
import 'package:dwarka_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, right: 5, bottom: 20, left: 20),
        child: ProductList(
          products: [
            model.Product(
              id: '1',
              title: 'Product 1',
              description: 'Description for Product 1',
              images: ['assets/images/products/Product_1.png'],
              price: 856.25,
              crossPrice: 799.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 4.5,
            ),
            model.Product(
              id: '2',
              title: 'Product 2',
              description: 'Description for Product 2',
              images: ['assets/images/products/product_2.png'],
              price: 956.25,
              crossPrice: 919.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 4.2,
            ),
            model.Product(
              id: '3',
              title: 'Product 3',
              description: 'Description for Product 3',
              images: ['assets/images/products/product_3.png'],
              price: 856.25,
              crossPrice: 799.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 4.0,
            ),
            model.Product(
              id: '4',
              title: 'Product 4',
              description: 'Description for Product 4',
              images: ['assets/images/products/product_4.png'],
              price: 656.25,
              crossPrice: 899.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 3.8,
            ),
            model.Product(
              id: '5',
              title: 'Product 1',
              description: 'Description for Product 1',
              images: ['assets/images/products/Product_1.png'],
              price: 956.25,
              crossPrice: 899.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 4.1,
            ),
            model.Product(
              id: '6',
              title: 'Product 2',
              description: 'Description for Product 2',
              images: ['assets/images/products/product_2.png'],
              price: 756.25,
              crossPrice: 959.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 4.0,
            ),
            model.Product(
              id: '7',
              title: 'Product 3',
              description: 'Description for Product 3',
              images: ['assets/images/products/product_3.png'],
              price: 756.25,
              crossPrice: 799.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 3.9,
            ),
            model.Product(
              id: '8',
              title: 'Product 4',
              description: 'Description for Product 4',
              images: ['assets/images/products/product_4.png'],
              price: 856.25,
              crossPrice: 699.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 4.2,
            ),
            model.Product(
              id: '9',
              title: 'Product 2',
              description: 'Description for Product 2',
              images: ['assets/images/products/product_2.png'],
              price: 756.25,
              crossPrice: 599.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 4.0,
            ),
            model.Product(
              id: '10',
              title: 'Product 3',
              description: 'Description for Product 3',
              images: ['assets/images/products/product_3.png'],
              price: 756.25,
              crossPrice: 999.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 3.8,
            ),
            model.Product(
              id: '11',
              title: 'Product 4',
              description: 'Description for Product 4',
              images: ['assets/images/products/product_4.png'],
              price: 656.25,
              crossPrice: 899.23,
              reviews: [],
              variants: [],
              category: 'Mens',
              rating: 3.7,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<model.Product> products;
  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 180, // ✅ compact grid like Amazon
        crossAxisSpacing: 8, // tighter spacing
        mainAxisSpacing: 12,
        childAspectRatio: 0.65, // taller cards (image + title + price)
      ),
      itemCount: products.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          imagePath: product.images.isNotEmpty ? product.images[0] : '',
          title: product.title,
          price: product.price.toString(),
          crossPrice: product.crossPrice.toString(),
          cardWidth: width < 400
              ? 135.0 // small phones (denser look)
              : width < 800
                  ? 150.0 // tablets
                  : 170.0, // desktops
        );
      },
    );
  }
}
