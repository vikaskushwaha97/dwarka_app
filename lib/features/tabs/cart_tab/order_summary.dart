import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:iconsax/iconsax.dart';
import '../../../models/address.dart';
import '../../../providers/cart_provider.dart';
import '../../../utils/constant.dart';
import 'order_confirmation.dart';
import '../../theme/theme_utils.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({super.key});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  String selectedPaymentMethod = 'UPI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Order Summary',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2,
              color: Theme.of(context).colorScheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer2<CartProvider, AddressProvider>(
        builder: (context, cartProvider, addressProvider, child) {
          final selectedAddress = addressProvider.defaultAddress;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Delivery Address Section
                SectionTitle(
                  title: 'Delivery Address',
                  icon: Iconsax.location,
                ),
                const SizedBox(height: 12),

                if (selectedAddress != null)
                  AddressCard(address: selectedAddress)
                else
                  const Text("No address selected. Please add one."),

                const SizedBox(height: 32),

                // Order Items Section
                SectionTitle(
                  title: 'Order Items',
                  icon: Iconsax.bag_2,
                ),
                const SizedBox(height: 12),
                OrderItemsList(items: cartProvider.items),
                const SizedBox(height: 32),

                // Payment Method Section
                SectionTitle(
                  title: 'Payment Method',
                  icon: Iconsax.card,
                ),
                const SizedBox(height: 12),
                PaymentMethodSelector(
                  selectedMethod: selectedPaymentMethod,
                  onMethodChanged: (method) {
                    setState(() {
                      selectedPaymentMethod = method;
                    });
                  },
                ),
                const SizedBox(height: 32),

                // Price Summary
                PriceSummary(cartProvider: cartProvider),
                const SizedBox(height: 32),

                // Place Order Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedAddress == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please select an address")),
                        );
                        return;
                      }
                      _placeOrder(context, cartProvider, selectedAddress);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: whiteColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  void _placeOrder(
      BuildContext context, CartProvider cartProvider, AddressModel address) {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      ),
    );

    // Simulate order processing
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog

      // Navigate to confirmation screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderConfirmationScreen(),
        ),
      );
    });
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class AddressCard extends StatelessWidget {
  final AddressModel address;

  const AddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
              Text(
                address.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Default',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            address.phone,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7)),
          ),
          const SizedBox(height: 8),
          Text(
            address.fullAddress,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.4),
          ),const SizedBox(height: 12),
          TextButton(
            onPressed: () async {
              final selectedAddress = await context.pushNamed<AddressModel?>('addresses');

              if (selectedAddress != null) {
                // Handle the selected address
                // For example, update your state or provider with the selected address
                print('Selected address: ${selectedAddress.title}');
              }
            },
            child: const Text(
              'Change Address',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItemsList extends StatelessWidget {
  final List<dynamic> items;

  const OrderItemsList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item.imagePath,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Size: ${item.size} | ${item.lensType}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Qty: ${item.quantity}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${item.totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          if (item.originalPrice > item.price)
                            Text(
                              '₹${item.originalPrice.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (index < items.length - 1)
                  Divider(
                    height: 1,
                    color: Colors.grey[200],
                  ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}

class PaymentMethodSelector extends StatelessWidget {
  final String selectedMethod;
  final Function(String) onMethodChanged;

  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onMethodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final paymentMethods = [
      {
        'id': 'UPI',
        'name': 'UPI',
        'icon': Iconsax.mobile,
        'description': 'Pay using UPI apps',
      },
      {
        'id': 'CARD',
        'name': 'Credit/Debit Card',
        'icon': Iconsax.card,
        'description': 'Visa, Mastercard, RuPay',
      },
      {
        'id': 'COD',
        'name': 'Cash on Delivery',
        'icon': Iconsax.money_send,
        'description': 'Pay when you receive',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: paymentMethods.asMap().entries.map((entry) {
          final index = entry.key;
          final method = entry.value;
          final isSelected = selectedMethod == method['id'];

          return Column(
            children: [
              RadioListTile<String>(
                value: method['id'].toString(),
                groupValue: selectedMethod,
                onChanged: (value) {
                  if (value != null) {
                    onMethodChanged(value);
                  }
                },
                activeColor: primaryColor,
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryColor.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        method['icon'] as IconData,
                        size: 18,
                        color: isSelected ? primaryColor : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          method['name'].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? primaryColor : blackColor,
                          ),
                        ),
                        Text(
                          method['description'].toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (index < paymentMethods.length - 1)
                Divider(
                  height: 1,
                  color: Colors.grey[200],
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class PriceSummary extends StatelessWidget {
  final CartProvider cartProvider;

  const PriceSummary({super.key, required this.cartProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: textFieldBackgroundColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildPriceRow(context, 'Subtotal', cartProvider.subtotal),
          const SizedBox(height: 8),
          _buildPriceRow(context, 'Tax (18% GST)', cartProvider.tax),
          if (cartProvider.totalSavings > 0) ...[
            const SizedBox(height: 8),
            _buildPriceRow(context, 'You Save', cartProvider.totalSavings, isSavings: true),
          ],
          const Divider(height: 20),
          _buildPriceRow(
            context,
            'Total',
            cartProvider.total,
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, double amount, {bool isTotal = false, bool isSavings = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isSavings ? Colors.green : Theme.of(context).colorScheme.onBackground,
              ),
        ),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: isSavings ? Colors.green : (isTotal ? primaryColor : Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ],
    );
  }
}
