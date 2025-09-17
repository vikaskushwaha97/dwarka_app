import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../models/address.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Addresses"),
      ),
      body: Consumer<AddressProvider>(
        builder: (context, addressProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: AddressList(addresses: addressProvider.addresses),
                ),
                const SizedBox(height: 16),
                const AddAddressButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AddressList extends StatelessWidget {
  final List<AddressModel> addresses;

  const AddressList({super.key, required this.addresses});

  @override
  Widget build(BuildContext context) {
    if (addresses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No addresses saved',
              style: AppStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first address to get started',
              style: AppStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: addresses.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final address = addresses[index];
        return AddressCard(
          address: address,
          onEdit: () => _handleEditAddress(context, address),
          onDelete: () => _handleDeleteAddress(context, address),
          onSetDefault: () => _handleSetDefaultAddress(context, address),
        );
      },
    );
  }

  void _handleEditAddress(BuildContext context, AddressModel address) {
    context.pushNamed('add-address', extra: address);
  }

  void _handleDeleteAddress(BuildContext context, AddressModel address) {
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
                final addressProvider = Provider.of<AddressProvider>(context, listen: false);
                addressProvider.deleteAddress(address.id);
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

  void _handleSetDefaultAddress(BuildContext context, AddressModel address) {
    final addressProvider = Provider.of<AddressProvider>(context, listen: false);
    addressProvider.setDefaultAddress(address.id);
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
  final AddressModel address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const AddressCard({
    super.key,
    required this.address,
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
                  address.title,
                  style: AppStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (address.isDefault)
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
              address.name,
              style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              address.phone,
              style: AppStyles.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              address.address,
              style: AppStyles.bodyLarge,
            ),
            if (address.landmark.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Landmark: ${address.landmark}',
                style: AppStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              ),
            ],
            const SizedBox(height: 4),
            Text(
              '${address.city}, ${address.state} - ${address.pincode}',
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
                if (!address.isDefault)
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