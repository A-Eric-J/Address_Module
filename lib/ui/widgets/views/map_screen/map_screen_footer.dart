import 'package:address_module/ui/widgets/views/map_screen/check_service_enabled.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:address_module/const_values/route_paths.dart';
import 'package:address_module/enums/address_state.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/generated/l10n.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:address_module/services/map_service.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/services/web_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/blog.dart';
import 'package:address_module/ui/widgets/button/button.dart';
import 'package:address_module/ui/widgets/button/icon_button.dart';
import 'package:address_module/ui/widgets/custom_modal.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';

/// [MapScreenFooter] has myLocation icon and submitting address button
class MapScreenFooter extends StatefulWidget {
  final AddressState addressState;
  final Address? address;

  const MapScreenFooter({Key? key, required this.addressState, this.address})
      : super(key: key);

  @override
  State<MapScreenFooter> createState() => _MapScreenFooterState();
}

class _MapScreenFooterState extends State<MapScreenFooter>
    with TickerProviderStateMixin {
  WebService? webService;

  @override
  void initState() {
    webService = Provider.of(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<MapProvider>(builder: (context, mapProvider, child) {
      return Padding(
        padding: EdgeInsets.only(bottom: width * 0.0213),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(
                width * 0.0213,
              ),
              child: Stroke(
                backgroundColor: white,
                onTap: () async {
                  var permission = await mapProvider
                      .requestServiceOrPermissionAndGetLocation();
                  if (permission == LocationPermission.always ||
                      permission == LocationPermission.whileInUse) {
                    if (!await mapProvider.checkServiceEnabled()) {
                      if (mounted) return;
                      showModal(context, false);
                    } else {
                      var position = await mapProvider.updateByMyLocation();
                      MapService.setAddress(webService!, mapProvider,
                          position.latitude, position.longitude,
                          editAddress: widget.address);
                      _animatedMapMove(position, mapProvider.zoom, mapProvider);
                    }
                  } else if (permission == LocationPermission.deniedForever) {
                    if (mounted) return;
                    showModal(context, true);
                  }
                },
                radius: width * 0.0213,
                child: Padding(
                  padding: EdgeInsets.all(width * 0.0213),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const MyLocationIcon(),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      TextView(
                        text: S.of(context).myLocationText,
                        size: 16,
                        color: brandMainColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: RectAngleButton(
                state: ViewState.ready,
                height: width * 0.1466,
                width: width,
                nameOfButton: S.of(context).locationRegistrationText,
                color: mapProvider.address != null ? brandMainColor : greyColor,
                onTap: mapProvider.address != null
                    ? () {
                        locator<NavigationService>().navigateTo(
                            RoutePaths.completingAddressPath,
                            arguments: {
                              'addressState': widget.addressState,
                              'address': mapProvider.address,
                            });
                      }
                    : null,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _animatedMapMove(
      LatLng destLocation, double destZoom, MapProvider mapProvider) {
    /// Create some tweens. These serve to split up the transition from one location to another.
    /// In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapProvider.mapController!.center.latitude,
        end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapProvider.mapController!.center.longitude,
        end: destLocation.longitude);
    final zoomTween =
        Tween<double>(begin: mapProvider.mapController!.zoom, end: destZoom);

    /// Create a animation controller that has a duration and a TickerProvider.
    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    /// The animation determines what path the animation will take. You can try different Curves values, although I found
    /// fastOutSlowIn to be my favorite.
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapProvider.mapController!.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void showModal(BuildContext context, bool isDeniedForever) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (builder) {
          return CustomModal(
            child: CheckServiceEnabled(isDeniedForever: isDeniedForever),
          );
        });
  }
}
