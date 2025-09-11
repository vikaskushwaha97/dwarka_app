import '../models/cart_item.dart';

class DemoData {
  static List<CartItem> getSampleCartItems() {
    return [
      CartItem(
        id: '1',
        title: 'Ray-Ban Aviator Classic',
        imagePath: 'assets/images/products/Product_1.png',
        price: 985.25,
        originalPrice: 1299.00,
        quantity: 1,
        size: 'M',
        lensType: 'Standard',
      ),
      CartItem(
        id: '2',
        title: 'Oakley Holbrook',
        imagePath: 'assets/images/products/product_2.png',
        price: 956.25,
        originalPrice: 1199.00,
        quantity: 2,
        size: 'L',
        lensType: 'Blue Light',
      ),
      CartItem(
        id: '3',
        title: 'Gucci GG0061S',
        imagePath: 'assets/images/products/product_3.png',
        price: 856.25,
        originalPrice: 1099.00,
        quantity: 1,
        size: 'M',
        lensType: 'Polarized',
      ),
    ];
  }
}
