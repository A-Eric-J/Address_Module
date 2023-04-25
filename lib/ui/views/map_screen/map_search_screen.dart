import 'package:address_module/ui/widgets/views/map_screen/map_search_screen/map_search_list.dart';
import 'package:flutter/material.dart';
import 'package:address_module/enums/appbar_state.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/generated/l10n.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:address_module/services/map_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/shared/text.dart';
import 'package:address_module/ui/widgets/blog.dart';
import 'package:address_module/ui/widgets/custom_appbar.dart';
import 'package:address_module/ui/widgets/masked_text_controller.dart';
import 'package:address_module/ui/widgets/search_bar.dart';
import 'package:provider/provider.dart';

/// You can search your desired address in [MapSearchScreen]
class MapSearchScreen extends StatefulWidget {
  const MapSearchScreen({Key? key}) : super(key: key);

  @override
  State<MapSearchScreen> createState() => _MapSearchScreenState();
}

class _MapSearchScreenState extends State<MapSearchScreen> {
  var textController = MaskedTextController(mask: '*', length: 100);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer<MapProvider>(builder: (context, mapProvider, snapshot) {
          return Column(
            children: [
              CustomAppBar(
                appBarState: AppBarState.backing,
                title: S.of(context).addressSearchText,
              ),
              SearchBar(
                textController: textController,
                backgroundColor: brandMainColor.withOpacity(0.8),
                labelText: searchLabelText,
                onChanged: (text) {
                  mapProvider.searchClear();
                  mapProvider.setText(text);
                  if (text.isNotEmpty) {
                    /// note that from this Api it gets the address information
                    MapService.setAddresses(
                      Provider.of(context, listen: false),
                      Provider.of(context, listen: false),
                    );
                  }
                },
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: width * 0.0266),
              ),
              Expanded(
                child: Column(
                  children: [
                    if (mapProvider.mapAddressesViewState != ViewState.busy &&
                        mapProvider.mapAddresses.isEmpty)
                      const PlaceHolderInEmptyState(
                        text: '',
                      )
                    else
                      Expanded(
                        child: MapSearchList(
                          padding: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                            top: width * 0.0,
                          ),
                          state: mapProvider.mapAddressesViewState,
                          addresses: mapProvider.mapAddresses,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
