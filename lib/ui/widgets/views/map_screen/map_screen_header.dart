import 'package:address_module/ui/widgets/views/map_screen/map_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:provider/provider.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/button/icon_button.dart';

/// [MapScreenHeader] has SearchBar and BackButton
class MapScreenHeader extends StatelessWidget {
  const MapScreenHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<MapProvider>(builder: (context, mapProvider, child) {
      return SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: width * 0.0213, right: width * 0.0106),
                  child: BackingIcon(
                    color: white,
                    onTap: () => locator<NavigationService>().goBack(),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.04,
                        top: width * 0.01,
                        left: width * 0.04),
                    child: const MapSearchBar()),
              ],
            ),
          ],
        ),
      );
    });
  }
}
