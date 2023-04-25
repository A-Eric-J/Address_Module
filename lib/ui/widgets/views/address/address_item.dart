import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:address_module/const_values/assets.dart';
import 'package:address_module/const_values/route_paths.dart';
import 'package:address_module/enums/address_state.dart';
import 'package:address_module/generated/l10n.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/providers/address_provider.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/blog.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';

/// [AddressItem] has address information like title, fullAddress ,postalCode and etc
class AddressItem extends StatelessWidget {
  final Address address;
  final bool? hasHorizontalPadding;
  final Function(Address)? choosingAddress;

  const AddressItem(
      {Key? key,
      required this.address,
      this.hasHorizontalPadding,
      this.choosingAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Consumer<AddressProvider>(
        builder: (context, addressProvider, child) {
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: width * 0.0133,
            horizontal: hasHorizontalPadding != null && hasHorizontalPadding!
                ? width * 0.04
                : 0.0),
        child: Stroke(
          onTap: () {
            if (choosingAddress != null) {
              choosingAddress!(address);
            }
          },
          width: width,
          radius: width * 0.0266,
          backgroundColor: white,
          child: Container(
            width: width,
            margin: EdgeInsets.all(width * 0.032),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  text: address.title ?? '',
                  size: 16,
                  color: primaryDark,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: width * 0.0133,
                ),
                Row(
                  children: [
                    const ImageAndIconFill(path: Assets.location, isSvg: true),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Expanded(
                      child: TextView(
                        text: address.fullAddress ?? '',
                        size: 14,
                        color: primaryTextColor,
                        overflow: TextOverflow.ellipsis,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: width * 0.0133,
                ),
                TextView(
                  text:
                      '${S.of(context).numberText} ${address.number} ${S.of(context).unitText} ${address.unit}',
                  size: 14,
                  color: primaryTextColor,
                  overflow: TextOverflow.ellipsis,
                  maxLine: 2,
                ),
                SizedBox(
                  height: width * 0.0133,
                ),
                Row(
                  children: [
                    const ImageAndIconFill(
                        path: Assets.postalCode, isSvg: true),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    TextView(
                      text: address.postalCode ?? '',
                      size: 14,
                      color: primaryTextColor,
                      overflow: TextOverflow.ellipsis,
                      maxLine: 1,
                    ),
                  ],
                ),
                SizedBox(
                  height: width * 0.0133,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Stroke(
                      backgroundColor: softBlue,
                      width: width * 0.1013,
                      height: width * 0.1013,
                      radius: width * 0.1013,
                      onTap: () => locator<NavigationService>()
                          .navigateTo(RoutePaths.mapScreenPath, arguments: {
                        'addressState': AddressState.updating,
                        'address': address
                      }),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.0266),
                        child: const ImageAndIconFill(
                          path: Assets.edit,
                          isSvg: true,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Stroke(
                      backgroundColor: softRed,
                      width: width * 0.1013,
                      height: width * 0.1013,
                      radius: width * 0.1013,
                      onTap: () => addressProvider.removeAddressItem(address),
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.0266),
                        child: const ImageAndIconFill(
                            path: Assets.trash, isSvg: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
