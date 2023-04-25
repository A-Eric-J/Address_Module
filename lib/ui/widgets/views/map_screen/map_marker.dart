import 'package:flutter/material.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:provider/provider.dart';

/// [MapMarker] is a custom widget for showing marker
class MapMarker extends StatelessWidget {
  const MapMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(builder: (context, mapProvider, child) {
      return Center(
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.only(bottom: 27),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: mapProvider.changeMarker ? 25 : 30,
                  height: mapProvider.changeMarker ? 25 : 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: brandMainColor),
                  child: Center(
                    child: Container(
                      width: mapProvider.changeMarker ? 15 : 20,
                      height: mapProvider.changeMarker ? 15 : 20,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: mapMarkerColor),
                      child: Center(
                        child: Container(
                          width: mapProvider.changeMarker ? 4 : 8,
                          height: mapProvider.changeMarker ? 4 : 8,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: white),
                        ),
                      ),
                    ),
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: mapProvider.changeMarker ? 29 : 8),
                      child: Container(
                        width: 2,
                        height: 17,
                        decoration: const BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3))),
                      ),
                    ),
                    Container(
                      width: mapProvider.changeMarker ? 30 : 16,
                      height: mapProvider.changeMarker ? 30 : 16,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: black.withOpacity(0.1)),
                      child: Center(
                        child: Container(
                          width: mapProvider.changeMarker ? 2 : 0,
                          height: mapProvider.changeMarker ? 2 : 0,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: black),
                        ),
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
