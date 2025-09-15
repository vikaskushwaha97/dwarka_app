import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Addresses'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed('add-address');            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saved Addresses',
              style: AppStyles.titleLarge,
            ),
            SizedBox(height: 16),
            Expanded(
              child: AddressList(),
            ),
            SizedBox(height: 16),
            AddAddressButton(),
          ],
        ),
      ),
    );
  }
}

class AddressList extends StatelessWidget {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = [
      _AddressData(
        title: 'Home Address',
        address: '123 Main Street\nDwarka, New Delhi 110075',
        isDefault: true,
      ),
      _AddressData(
        title: 'Work Address',
        address: '456 Office Road\nSector 12, Dwarka\nNew Delhi 110078',
        isDefault: false,
      ),
      _AddressData(
        title: 'Parents House',
        address: '789 Family Avenue\nUttam Nagar\nNew Delhi 110059',
        isDefault: false,
      ),
    ];

    return ListView.separated(
      itemCount: addresses.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final address = addresses[index];
        return AddressCard(
          title: address.title,
          address: address.address,
          isDefault: address.isDefault,
          onEdit: () => _handleEditAddress(context, address),
          onDelete: () => _handleDeleteAddress(context, address),
          onSetDefault: () => _handleSetDefaultAddress(context, address),
        );
      },
    );
  }

  void _handleEditAddress(BuildContext context, _AddressData address) {
    // TODO: Implement edit address functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit ${address.title}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleDeleteAddress(BuildContext context, _AddressData address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: Text('Are you sure you want to delete "${address.title}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${address.title} deleted'),
                    backgroundColor: AppColors.error,
                  ),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleSetDefaultAddress(BuildContext context, _AddressData address) {
    // TODO: Implement set default address functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${address.title} set as default'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.pushNamed('add-address');
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text(
          'Add New Address',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final String title;
  final String address;
  final bool isDefault;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const AddressCard({
    super.key,
    required this.title,
    required this.address,
    required this.isDefault,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'DEFAULT',
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              address,
              style: AppStyles.bodyLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: onEdit,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 36),
                  ),
                  child: Text(
                    'Edit',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: onDelete,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 36),
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const Spacer(),
                if (!isDefault)
                  TextButton(
                    onPressed: onSetDefault,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 36),
                    ),
                    child: Text(
                      'Set as Default',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressData {
  final String title;
  final String address;
  final bool isDefault;

  _AddressData({
    required this.title,
    required this.address,
    required this.isDefault,
  });
}