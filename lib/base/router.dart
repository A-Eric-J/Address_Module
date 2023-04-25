import 'package:address_module/const_values/route_paths.dart';
import 'package:address_module/enums/address_state.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/ui/views/address/address_screen.dart';
import 'package:address_module/ui/views/map_screen/completing_address.dart';
import 'package:address_module/ui/views/map_screen/map_screen.dart';
import 'package:address_module/ui/views/map_screen/map_search_screen.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';
import 'package:flutter/material.dart';

/// All the Routes for navigating are placed here
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.mapScreenPath:
        var arguments = settings.arguments as Map<String, dynamic>;
        var addressState = arguments['addressState'] as AddressState;
        var address = arguments['address'] as Address?;
        return MaterialPageRoute(
            builder: (_) => MapScreen(
                  addressState: addressState,
                  address: address,
                ));
      case RoutePaths.completingAddressPath:
        var arguments = settings.arguments as Map<String, dynamic>;
        var addressState = arguments['addressState'] as AddressState;
        var address = arguments['address'] as Address;
        return MaterialPageRoute(
            builder: (_) => CompletingAddressScreen(
                addressState: addressState, address: address));
      case RoutePaths.mapSearchScreenPath:
        return MaterialPageRoute(builder: (_) => const MapSearchScreen());
      case RoutePaths.addressScreen:
        return MaterialPageRoute(builder: (_) => const AddressScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: TextView(
                      text: 'No route defined for ${settings.name}',
                      size: 16,
                    ),
                  ),
                ));
    }
  }
}
