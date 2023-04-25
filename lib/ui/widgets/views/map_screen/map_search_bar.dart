import 'package:flutter/material.dart';
import 'package:address_module/const_values/route_paths.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/animation/custom_loading.dart';
import 'package:address_module/ui/widgets/blog.dart';
import 'package:address_module/ui/widgets/button/icon_button.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';
import 'package:provider/provider.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<MapProvider>(builder: (context, mapProvider, child) {
      return Stroke(
        width: width,
        onTap: () {
          locator<NavigationService>()
              .navigateTo(RoutePaths.mapSearchScreenPath);
        },
        backgroundColor: disableTextFiledColor,
        radius: width * 0.0266,
        child: Padding(
          padding: EdgeInsets.all(width * 0.0293),
          child: Row(
            children: [
              const SearchIcon(),
              SizedBox(
                width: width * 0.0266,
              ),
              (mapProvider.addressViewState == ViewState.busy ||
                      mapProvider.address == null)
                  ? Center(
                      child: SizedBox(
                        width: width * 0.05,
                        height: width * 0.05,
                        child: const CustomLoading(
                          colors: [brandMainColor],
                        ),
                      ),
                    )
                  : Expanded(
                      child: TextView(
                        text: mapProvider.address!.fullAddress!,
                        overflow: TextOverflow.ellipsis,
                        size: 14,
                        color: primaryTextColor,
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
