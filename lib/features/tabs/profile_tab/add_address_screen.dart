// add_address_screen.dart - Complete implementation with form
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../models/address.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressModel? editAddress;

  const AddAddressScreen({super.key, this.editAddress});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  String _selectedType = 'home';
  String _title = 'Home Address';
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();

    // Pre-fill form if editing
    if (widget.editAddress != null) {
      final address = widget.editAddress!;
      _nameController.text = address.name;
      _phoneController.text = address.phone;
      _pincodeController.text = address.pincode;
      _addressController.text = address.address;
      _landmarkController.text = address.landmark;
      _cityController.text = address.city;
      _stateController.text = address.state;
      _selectedType = address.type;
      _title = address.title;
      _isDefault = address.isDefault;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _pincodeController.dispose();
    _addressController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  void _updateTitle(String type) {
    setState(() {
      _selectedType = type;
      switch (type) {
        case 'home':
          _title = 'Home Address';
          break;
        case 'work':
          _title = 'Work Address';
          break;
        case 'other':
          _title = 'Other Address';
          break;
      }
    });
  }

  void _saveAddress() {
    if (_formKey.currentState!.validate()) {
      final addressProvider = Provider.of<AddressProvider>(context, listen: false);
      final newAddress = AddressModel(
        id: widget.editAddress?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        type: _selectedType,
        title: _title,
        name: _nameController.text,
        phone: _phoneController.text,
        pincode: _pincodeController.text,
        address: _addressController.text,
        landmark: _landmarkController.text,
        city: _cityController.text,
        state: _stateController.text,
        isDefault: _isDefault,
      );

      if (widget.editAddress != null) {
        addressProvider.updateAddress(widget.editAddress!.id, newAddress);
      } else {
        addressProvider.addAddress(newAddress);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.editAddress != null ? 'Address updated' : 'Address added'),
          backgroundColor: AppColors.success,
        ),
      );

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editAddress != null ? "Edit Address" : "Add Address"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveAddress,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Address Type Selection
              _buildTypeSelector(),
              const SizedBox(height: 20),

              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Field
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length != 10) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Pincode Field
              TextFormField(
                controller: _pincodeController,
                decoration: const InputDecoration(
                  labelText: 'Pincode',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pincode';
                  }
                  if (value.length != 6) {
                    return 'Please enter a valid 6-digit pincode';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Address Field
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Landmark Field
              TextFormField(
                controller: _landmarkController,
                decoration: const InputDecoration(
                  labelText: 'Landmark (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // City Field
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your city';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // State Field
              TextFormField(
                controller: _stateController,
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your state';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Default Address Checkbox
              CheckboxListTile(
                title: const Text('Set as default address'),
                value: _isDefault,
                onChanged: (value) {
                  setState(() {
                    _isDefault = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: _saveAddress,
                child: Text(widget.editAddress != null ? 'Update Address' : 'Save Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Row(
      children: [
        _TypeChip(
          label: 'Home',
          icon: Icons.home,
          isSelected: _selectedType == 'home',
          onSelected: () => _updateTitle('home'),
        ),
        const SizedBox(width: 10),
        _TypeChip(
          label: 'Work',
          icon: Icons.work,
          isSelected: _selectedType == 'work',
          onSelected: () => _updateTitle('work'),
        ),
        const SizedBox(width: 10),
        _TypeChip(
          label: 'Other',
          icon: Icons.location_on,
          isSelected: _selectedType == 'other',
          onSelected: () => _updateTitle('other'),
        ),
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onSelected;

  const _TypeChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: AppColors.primary,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : null,
      ),
    );
  }
}