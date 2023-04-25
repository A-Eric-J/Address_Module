import 'package:address_module/providers/address_provider.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:address_module/services/cookie_service.dart';
import 'package:address_module/services/web_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// provider_setup initializes the providers that are using in this app

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];
List<SingleChildWidget> independentServices = [
  Provider.value(value: CookieService()),
  ListenableProvider.value(value: MapProvider()),
  ListenableProvider.value(value: AddressProvider()),
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<CookieService, WebService>(
    update: (context, cookieService, webService) => webService == null
        ? WebService(
            cookieService: cookieService,
          )
        : webService.setDependencies(cookieService),
    create: (context) => WebService(),
  ),
];
