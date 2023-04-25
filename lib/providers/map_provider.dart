import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/models/map.dart';
import 'package:latlong2/latlong.dart';

/// [MapProvider] for all of Map behaviours, we use flutter_map and geolocator

class MapProvider extends ChangeNotifier {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  var isLoadingSavedLocations = true;
  var isLoadingFullAddress = true;
  var isEmpty = false;
  var zoom = 13.0;
  var minZoom = 11.0;
  var maxZoom = 22.0;
  var _changeMarker = false;
  int _counterMarker = 0;
  MapController? mapController;
  AnimationController? animationController;
  LocationPermission locationPermission = LocationPermission.denied;
  LatLng? initialMapPosition;
  LatLng? newLatLng;
  LatLng? myCurrentPosition;

  /// [defaultLatLng] is Azadi Square in Tehran Iran
  LatLng defaultLatLng = LatLng(35.68981142671681, 51.38959586620331);
  bool _initialMoving = true;

  bool get changeMarker => _changeMarker;

  void setChangeMarker(bool marker) {
    _changeMarker = marker;
    log('setChangeMarker  $_changeMarker');
    notifyListeners();
  }

  int get counterMarker => _counterMarker;

  void setCounterMarker(int newCounterMarker) {
    _counterMarker = newCounterMarker;
    notifyListeners();
  }

  Future<LatLng> setInitialMapPosition(Address? editAddress) async {
    mapController = MapController();
    var currentPosition = await getCurrentPosition();

    if (editAddress == null) {
      if (currentPosition != null) {
        initialMapPosition =
            LatLng(currentPosition.latitude, currentPosition.longitude);
        myCurrentPosition = initialMapPosition;
        newLatLng = initialMapPosition;
      } else {
        initialMapPosition = defaultLatLng;
        newLatLng = initialMapPosition;
      }
    } else {
      initialMapPosition = LatLng(editAddress.geoLat!, editAddress.geoLong!);
      newLatLng = LatLng(editAddress.geoLat!, editAddress.geoLong!);
      _address = editAddress;
      if (currentPosition != null) {
        myCurrentPosition =
            LatLng(currentPosition.latitude, currentPosition.longitude);
      }
    }
    notifyListeners();
    return newLatLng!;
  }

  void setInitialMoving(bool newBoolState) {
    _initialMoving = newBoolState;
  }

  bool get initialMoving => _initialMoving;

  Future<void> onCreated(MapController newMapController) async {
    mapController = newMapController;
    notifyListeners();
  }

  void disposeController() {
    mapController!.dispose();
  }

  Future<LatLng> updateByMyLocation() async {
    LatLng location = await _geolocatorPlatform
        .getCurrentPosition()
        .then((value) => LatLng(value.latitude, value.longitude));
    log("get current position.");
    notifyListeners();
    return LatLng(location.latitude, location.longitude);
  }

  void updateBySearch(Address newAddress) async {
    _address = newAddress;
    newLatLng = LatLng(newAddress.geoLat!, newAddress.geoLong!);
    mapController!.move(LatLng(newAddress.geoLat!, newAddress.geoLong!), zoom);
    notifyListeners();
  }

  Future<LocationPermission> requestServiceOrPermissionAndGetLocation() async {
    LocationPermission permission = LocationPermission.denied;
    permission = await _geolocatorPlatform
        .checkPermission()
        .onError((error, stackTrace) {
      log('Error: $error');
      return LocationPermission.always;
    });

    log("get location permission status");
    if (permission == LocationPermission.denied) {
      log("access denied");
      permission = await _geolocatorPlatform.requestPermission();
    }

    return permission;
  }

  Future<LatLng?> getCurrentPosition() async {
    var permission = await requestServiceOrPermissionAndGetLocation();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return await _geolocatorPlatform
          .getCurrentPosition()
          .then((value) => LatLng(value.latitude, value.longitude))
          .onError((error, stackTrace) =>
              LatLng(defaultLatLng.latitude, defaultLatLng.longitude));
    }

    return defaultLatLng;
  }

  void updatePoint(MapEvent? event, double pointX, double pointY) {
    newLatLng = mapController!.pointToLatLng(CustomPoint(pointX, pointY));
  }

  Future<bool> checkServiceEnabled() async {
    return await _geolocatorPlatform.isLocationServiceEnabled();
  }

  Address? _address;

  Address? get address => _address;

  void setAddress(Address address) {
    _address = address;
    notifyListeners();
  }

  ViewState _addressViewState = ViewState.preparing;

  ViewState get addressViewState => _addressViewState;

  void setAddressViewState(ViewState newState) {
    _addressViewState = newState;
    notifyListeners();
  }

  List<MapModel> _mapAddresses = [];

  List<MapModel> get mapAddresses => _mapAddresses;

  void setMapAddresses(List<MapModel> addresses) {
    if (_text.isEmpty) {
      searchClear();
    } else {
      _mapAddresses = addresses;
      notifyListeners();
    }
  }

  ViewState _mapAddressesViewState = ViewState.preparing;

  ViewState get mapAddressesViewState => _mapAddressesViewState;

  void setMapAddressesViewState(ViewState newState) {
    _mapAddressesViewState = newState;
    notifyListeners();
  }

  var _text = '';

  String get text => _text;

  void setText(String text) {
    _text = text;
  }

  void searchClear() {
    _text = '';
    _mapAddressesViewState = ViewState.preparing;
    _mapAddresses.clear();
    notifyListeners();
  }

  void clear() {
    _changeMarker = false;
    _counterMarker = 0;
    initialMapPosition = null;
    newLatLng = null;
    _initialMoving = true;
    _address = null;
    searchClear();
    disposeController();
  }
}
