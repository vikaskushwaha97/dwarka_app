import 'package:flutter/foundation.dart';

class AddressModel { // Changed from Address to AddressModel
  final String id;
  final String type;
  final String title;
  final String name;
  final String phone;
  final String pincode;
  final String address;
  final String landmark;
  final String city;
  final String state;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.type,
    required this.title,
    required this.name,
    required this.phone,
    required this.pincode,
    required this.address,
    required this.landmark,
    required this.city,
    required this.state,
    this.isDefault = false,
  });

  // Add this getter for full address display
  String get fullAddress {
    final parts = [address];
    if (landmark.isNotEmpty) parts.add(landmark);
    parts.addAll([city, state, pincode]);
    return parts.join(', ');
  }

  AddressModel copyWith({
    String? id,
    String? type,
    String? title,
    String? name,
    String? phone,
    String? pincode,
    String? address,
    String? landmark,
    String? city,
    String? state,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      pincode: pincode ?? this.pincode,
      address: address ?? this.address,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
class AddressProvider with ChangeNotifier {
  final List<AddressModel> _addresses = [ // Changed to AddressModel
    AddressModel(
      id: '1',
      type: 'home',
      title: 'Home Address',
      name: 'Vikas Kushwaha',
      phone: '7588970296',
      pincode: '110075',
      address: '123 Main Street\nDwarka',
      landmark: 'Near Metro Station',
      city: 'New Delhi',
      state: 'Delhi',
      isDefault: true,
    ),
    AddressModel(
      id: '2',
      type: 'work',
      title: 'Work Address',
      name: 'Vikas Kushwaha',
      phone: '7588970296',
      pincode: '110078',
      address: '456 Office Road\nSector 12',
      landmark: 'Opposite Shopping Mall',
      city: 'New Delhi',
      state: 'Delhi',
      isDefault: false,
    ),
  ];

  List<AddressModel> get addresses => _addresses; // Changed to AddressModel

  AddressModel? get defaultAddress { // Changed to AddressModel
    try {
      return _addresses.firstWhere((address) => address.isDefault);
    } catch (e) {
      return _addresses.isNotEmpty ? _addresses.first : null;
    }
  }

  void addAddress(AddressModel newAddress) { // Changed to AddressModel
    // If new address is set as default, remove default from others
    if (newAddress.isDefault) {
      for (var i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(isDefault: false);
      }
    }

    _addresses.add(newAddress);
    notifyListeners();
  }

  void updateAddress(String id, AddressModel updatedAddress) { // Changed to AddressModel
    final index = _addresses.indexWhere((address) => address.id == id);
    if (index != -1) {
      // If updated address is set as default, remove default from others
      if (updatedAddress.isDefault) {
        for (var i = 0; i < _addresses.length; i++) {
          if (_addresses[i].id != id) {
            _addresses[i] = _addresses[i].copyWith(isDefault: false);
          }
        }
      }

      _addresses[index] = updatedAddress;
      notifyListeners();
    }
  }

  void deleteAddress(String id) {
    _addresses.removeWhere((address) => address.id == id);
    notifyListeners();
  }

  void setDefaultAddress(String id) {
    for (var i = 0; i < _addresses.length; i++) {
      _addresses[i] = _addresses[i].copyWith(isDefault: _addresses[i].id == id);
    }
    notifyListeners();
  }
}