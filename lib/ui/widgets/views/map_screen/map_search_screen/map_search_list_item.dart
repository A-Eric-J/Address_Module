import 'package:flutter/material.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/models/map.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/button/icon_button.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';
import 'package:provider/provider.dart';

/// Every [MapSearchListItem] has title and fullAddress
class MapSearchListItem extends StatelessWidget {
  final MapModel address;
  final int index;

  const MapSearchListItem({
    Key? key,
    required this.address,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<MapProvider>(builder: (context, mapProvider, child) {
      return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          mapProvider.updateBySearch(
              Address(address.geoLat, address.geoLong, address.address));
          locator<NavigationService>().goBack();
        },
        child: Padding(
          padding: EdgeInsets.only(top: width * 0.03466),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.0213),
                    child: const CircleRoundedIcon(
                      color: primaryGray,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.0213),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextView(
                              text: address.title!,
                              size: 16,
                              color: primaryTextColor,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis),
                          TextView(
                            text: address.address!,
                            size: 12,
                            color: primaryGray,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider()
            ],
          ),
        ),
      );
    });
  }
}
