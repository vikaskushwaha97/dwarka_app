import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  // Internal list to store cart items
  final List<CartItem> _items = [];

  // Expose a read-only view of cart items
  List<CartItem> get items => List.unmodifiable(_items);

  // Total number of units across all cart items
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  // Sum of (price * quantity) for each item
  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);

  // Dummy tax calculation (18% GST)
  double get tax => subtotal * 0.18; // 18% GST

  // Final payable amount
  double get total => subtotal + tax;

  // Total savings vs original prices
  double get totalSavings => _items.fold(0, (sum, item) => sum + item.savings);

  // Add an item to cart or update quantity if it already exists
  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((cartItem) => cartItem.id == item.id);
    
    if (existingIndex >= 0) {
      _items[existingIndex].quantity += item.quantity;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  // Remove item from cart by id
  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  // Set a specific quantity for an item
  void updateQuantity(String itemId, int newQuantity) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (newQuantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = newQuantity;
      }
      notifyListeners();
    }
  }

  // Increase quantity by 1
  void incrementQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity by 1 (remove item if reaches 0)
  void decrementQuantity(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  // Remove all items from the cart
  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Convenience getters
  bool get isEmpty => _items.isEmpty;

  bool get isNotEmpty => _items.isNotEmpty;
}
