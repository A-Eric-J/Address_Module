import 'package:flutter/material.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/models/address.dart';

/// [AddressProvider] is a provider for setting, adding, removing addresses and etc

class AddressProvider extends ChangeNotifier {
  ViewState _addressViewState = ViewState.preparing;

  ViewState get addressViewState => _addressViewState;

  void setAddressViewState(ViewState newState) {
    _addressViewState = newState;
    notifyListeners();
  }

  var _addresses = <Address>[];

  List<Address> get addresses =>  _addresses;


  void setAddresses(List<Address> newAddresses) {
    _addresses = newAddresses;
    notifyListeners();
  }


  void addNewAddress(Address newAddress) {
    _addresses.add(newAddress);
    notifyListeners();
  }

  void removeAddressItem(Address address){
    _addresses.remove(address);
    notifyListeners();

  }

  void clearAddressList() {
    _addresses.clear();
  }

  void updateAddress(Address updatedAddress) {
    var index =
        _addresses.indexWhere((address) => address.id == updatedAddress.id);
    if (index < 0) {
      _addresses.add(updatedAddress);
    } else {
      _addresses.removeAt(index);
      _addresses.insert(index, updatedAddress);
    }
    notifyListeners();
  }

}
