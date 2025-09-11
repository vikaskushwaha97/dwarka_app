class CartItem {
  final String id;
  final String title;
  final String imagePath;
  final double price;
  final double originalPrice;
  int quantity;
  final String size;
  final String lensType;

  CartItem({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.price,
    required this.originalPrice,
    this.quantity = 1,
    this.size = 'M',
    this.lensType = 'Standard',
  });

  double get totalPrice => price * quantity;
  double get savings => (originalPrice - price) * quantity;

  CartItem copyWith({
    String? id,
    String? title,
    String? imagePath,
    double? price,
    double? originalPrice,
    int? quantity,
    String? size,
    String? lensType,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      lensType: lensType ?? this.lensType,
    );
  }
}
