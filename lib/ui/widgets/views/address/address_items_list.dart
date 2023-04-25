import 'package:address_module/ui/widgets/views/address/address_item.dart';
import 'package:address_module/ui/widgets/views/address/address_item_in_busy_state.dart';
import 'package:flutter/material.dart';
import 'package:address_module/const_values/assets.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/providers/address_provider.dart';
import 'package:provider/provider.dart';

class AddressItemsList extends StatelessWidget {
  final Function(Address)? choosingAddress;
  final bool hasSpaceInLastItem;
  final bool hasHorizontalPadding;

  const AddressItemsList(
      {Key? key,
      this.hasSpaceInLastItem = true,
      this.hasHorizontalPadding = false,
      this.choosingAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer<AddressProvider>(
        builder: (context, addressProvider, child) {
      bool shimmerState = (addressProvider.addressViewState == ViewState.busy);
      return SizedBox(
        width: width,
        child: ListView.builder(
            padding: const EdgeInsets.all(0.0),
            shrinkWrap: true,
            itemCount:
                shimmerState ? busyCounter : addressProvider.addresses.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var lastItem = addressProvider.addresses.length - 1 == index;

              return shimmerState
                  ? const AddressItemInBusyState()
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: lastItem && hasSpaceInLastItem
                              ? width * 0.1866
                              : 0),
                      child: AddressItem(
                        hasHorizontalPadding: hasHorizontalPadding,
                        address: addressProvider.addresses[index],
                        choosingAddress: choosingAddress,
                      ),
                    );
            }),
      );
    });
  }
}
