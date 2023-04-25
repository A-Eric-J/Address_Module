/// [MapModel] based on map.ir response
class MapModel {
  String? province;
  String? city;
  String? title;
  String? address;
  String? addressCompact;
  double? geoLat;
  double? geoLong;

  MapModel.fromJsonInSearch(Map<String, dynamic> json) {
    province = json['province'] ?? '';
    city = json['city'] ?? '';
    title = json['title'] ?? '';
    address = json['address'] ?? '';

    if (json['geom']['coordinates'] is List) {
      geoLong =
          double.parse((json['geom']['coordinates'] as List)[0].toString());
      geoLat =
          double.parse((json['geom']['coordinates'] as List)[1].toString());
    }
  }

  MapModel.fromJsonInAddress(Map<String, dynamic> json) {
    province = json['province'] ?? '';
    city = json['city'] ?? '';
    title = json['title'] ?? '';
    address = json['address_compact'] ?? '';

    if (json['geom']['coordinates'] is List) {
      geoLong =
          double.parse((json['geom']['coordinates'] as List)[0].toString());
      geoLat =
          double.parse((json['geom']['coordinates'] as List)[1].toString());
    }
  }
}
