import 'dart:developer';

import 'package:address_module/ui/widgets/views/map_screen/map_marker.dart';
import 'package:address_module/ui/widgets/views/map_screen/map_screen_footer.dart';
import 'package:address_module/ui/widgets/views/map_screen/map_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:address_module/enums/address_state.dart';
import 'package:address_module/enums/gradient_type.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:address_module/services/map_service.dart';
import 'package:address_module/services/web_service.dart';
import 'package:address_module/ui/widgets/button/icon_button.dart';
import 'package:address_module/ui/widgets/gradient.dart';

/// [MapScreen] is a Custom Map based on flutter_map
class MapScreen extends StatefulWidget {
  final AddressState addressState;
  final Address? address;

  const MapScreen({Key? key, required this.addressState, this.address})
      : super(key: key);

  @override
  State<MapScreen> createState() {
    return _MapScreen();
  }
}

class _MapScreen extends State<MapScreen> {
  MapProvider? mapProvider;
  final pointSize = 40.0;

  /// we use [setAddress] Api for getting fullAddress based on the user location
  /// and if it could not get the user location it uses its default
  @override
  void initState() {
    super.initState();
    mapProvider = Provider.of(context, listen: false);
    var webService = Provider.of<WebService>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var latLng = await mapProvider!.setInitialMapPosition(widget.address);
      MapService.setAddress(
          webService, mapProvider!, latLng.latitude, latLng.longitude,
          editAddress: widget.address);
    });
  }

  double _getPointX(BuildContext context) {
    return MediaQuery.of(context).size.width / 2;
  }

  double _getPointY(BuildContext context) {
    return MediaQuery.of(context).size.height / 2;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<MapProvider>(builder: (context, mapProvider, child) {
        if (mapProvider.initialMoving) {
          /// this is for initial moving of the map
          try {
            if (mapProvider.mapController?.center != null) {
              mapProvider.mapController
                  ?.move(mapProvider.initialMapPosition!, mapProvider.zoom);
              mapProvider.setInitialMoving(false);
            }
          } catch (err) {
            log('error: $err');
          }
        }
        return Stack(
          children: [
            FlutterMap(
              mapController: mapProvider.mapController,
              options: MapOptions(
                onMapReady: () {},
                interactiveFlags:
                    InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                onMapEvent: (event) {
                  log('event ${event.source.index}');
                  if (event.source.index == 6) {
                    /// onDrag
                    if (mapProvider.counterMarker == 0) {
                      mapProvider.setChangeMarker(true);
                      mapProvider
                          .setCounterMarker(mapProvider.counterMarker + 1);
                    }
                  } else if (event.source.index == 7) {
                    /// dragEnd
                    mapProvider.setCounterMarker(0);
                    mapProvider.setChangeMarker(false);
                    MapService.setAddress(
                        Provider.of(context, listen: false),
                        mapProvider,
                        mapProvider.newLatLng!.latitude,
                        mapProvider.newLatLng!.longitude,
                        editAddress: widget.address);
                  }

                  mapProvider.updatePoint(
                      null, _getPointX(context), _getPointY(context));
                },
                center:
                    mapProvider.initialMapPosition ?? mapProvider.defaultLatLng,
                keepAlive: true,
                zoom: mapProvider.zoom,
                minZoom: mapProvider.minZoom,
                maxZoom: mapProvider.maxZoom,
              ),
              children: [
                TileLayer(
                  /// these are another styles for showing map and you can see my answer on stackoverflow too about these styles:
                  /// https://stackoverflow.com/questions/75865876/styling-map-of-flutter-map-package/75866244#75866244
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  // urlTemplate: 'https://basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                if (mapProvider.myCurrentPosition != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: width * 0.2666,
                        height: width * 0.2666,
                        point: mapProvider.myCurrentPosition!,
                        builder: (ctx) => const AccessibilityIcon(),
                      )
                    ],
                  )
              ],
            ),
            MainGradient(
                gradientType: GradientType.mapScreen,
                child: SizedBox(
                  width: width,
                  height: width * 0.32,
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: MainGradient(
                  gradientType: GradientType.mapScreen,
                  child: SizedBox(
                    width: width,
                    height: width * 0.38,
                  )),
            ),
            const SafeArea(child: MapScreenHeader()),
            const MapMarker(),
            SafeArea(
                child: MapScreenFooter(
              addressState: widget.addressState,
              address: widget.address,
            ))
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mapProvider!.clear();
    });
  }
}
