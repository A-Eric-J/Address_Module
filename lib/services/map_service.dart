import 'dart:developer';

import 'package:address_module/const_values/urls.dart';
import 'package:address_module/enums/response_status.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/models/debouncer.dart';
import 'package:address_module/models/map.dart';
import 'package:address_module/providers/map_provider.dart';
import 'package:address_module/services/web_service.dart';

/// [MapService] uses map.ir Apis from here: https://map.ir/
/// You can use googleMap Api instead because this Apis are for persian using
/// if you don't have access to it you can try others ways like googleMap
class MapService {
  static final DeBouncer searchDeBouncer = DeBouncer(milliseconds: 500);

  static void setAddress(
      WebService webService, MapProvider mapProvider, double lat, double long,
      {Address? editAddress}) async {
    var addParam = '';
    addParam = 'lat=${lat.toString()}&lon=${long.toString()}';
    mapProvider.setAddressViewState(ViewState.busy);

    var response = await webService.getFunction(URLs.mapAddress + addParam,
        mapToken: true);
    if (response.responseStatus == ResponseStatus.success) {
      var mapAddress = MapModel.fromJsonInAddress(response.body!);
      var newAddress =
          Address(mapAddress.geoLat, mapAddress.geoLong, mapAddress.address);
      if (editAddress != null) {
        newAddress.id = editAddress.id;
        newAddress.title = editAddress.title;
        newAddress.postalCode = editAddress.postalCode;
        newAddress.number = editAddress.number;
        newAddress.unit = editAddress.unit;
      }
      mapProvider.setAddress(newAddress);
      mapProvider.setAddressViewState(ViewState.ready);
      log('response.body: ${response.body}');
    } else {
      mapProvider.setAddressViewState(ViewState.failed);
    }
  }

  static void setAddresses(
    WebService webService,
    MapProvider mapProvider,
  ) async {
    // var filter = '';
    // filter = 'province eq $province';
    Map<String, String> body = {
      'text': mapProvider.text,
      // '\$filter': filter,
      '\$select': "neighborhood,roads,woodwater,poi"
    };
    mapProvider.setMapAddressesViewState(ViewState.busy);
    searchDeBouncer.run(() async {
      var response = await webService.postFunction(URLs.mapSearch,
          body: body, mapToken: true, withContentType: true);
      if (response.responseStatus == ResponseStatus.success) {
        var addresses = <MapModel>[];
        if ((response.body as Map).isNotEmpty) {
          for (var json in (response.body!['value'] as List)) {
            addresses.add(MapModel.fromJsonInSearch(json));
          }
        }
        mapProvider.setMapAddresses(addresses);
        mapProvider.setMapAddressesViewState(ViewState.ready);
        log('response.body: ${response.body}');
      } else {
        mapProvider.setMapAddressesViewState(ViewState.failed);
      }
    });
  }
}
