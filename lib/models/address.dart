/// Here is an example of [Address] model, you can add or remove variables that you want
/// this model has fromJson that converts a json item of address to address object
/// and if you want to export the object the a Json you can use toJson

class Address {
  int? id;
  String? title;
  double? geoLat;
  double? geoLong;
  String? fullAddress;
  int? number;
  int? unit;
  String? postalCode;

  Address(this.geoLat, this.geoLong, this.fullAddress,
      {this.id, this.title, this.number, this.unit, this.postalCode});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'] ?? '';
    geoLat = json['geoLat'] ?? 0.0;
    geoLong = json['geoLong'] ?? 0.0;
    fullAddress = json['fullAddress'] ?? '';
    number = json['number'] ?? 0;
    unit = json['unit'] ?? 0;
    postalCode = json['postalCode'] ?? '';
  }

  Map<String, dynamic> toJson() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['geoLat'] = geoLat;
    data['geoLong'] = geoLong;
    data['fullAddress'] = fullAddress;
    data['number'] = geoLong;
    data['unit'] = fullAddress;
    data['postalCode'] = postalCode;
    return data;
  }

  @override
  bool operator ==(other) {
    return (other is Address) &&
        other.id == id &&
        other.title == title &&
        other.geoLat == geoLat &&
        other.geoLong == geoLong &&
        other.fullAddress == fullAddress &&
        other.number == number &&
        other.unit == unit &&
        other.postalCode == postalCode;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      geoLat.hashCode ^
      geoLong.hashCode ^
      fullAddress.hashCode ^
      number.hashCode ^
      unit.hashCode ^
      postalCode.hashCode;
}

var addressMock = [
  {
    'id': 1,
    'title': 'خانه',
    'geoLat': 35.7771810,
    'geoLong': 51.4148500,
    'fullAddress': 'خیابان ولیعصر، روبه روی پارک ملت، خیابان حق شناس',
    'postalCode': '1234567890',
    'number': 64,
    'unit': 8,
  },
  {
    'id': 2,
    'title': 'شرکت',
    'geoLat': 35.7695673,
    'geoLong': 51.4139916,
    'fullAddress': 'خیابان ولیعصر،نرسیده به نیایش، خیابان ناصری',
    'postalCode': '1234567890',
    'number': 6,
    'unit': 7,
  },
  {
    'id': 3,
    'title': 'مترو میرداماد',
    'geoLat': 35.760001,
    'geoLong': 51.433846,
    'fullAddress': 'خیابان شریعتی،بلوار میرداماد، نبش خیابان شمس تبریزی',
    'postalCode': '1234567890',
    'number': 6,
    'unit': 9,
  },
  {
    'id': 4,
    'title': 'دفتر ترجمه 1',
    'geoLat': 35.7571450,
    'geoLong': 51.4104030,
    'fullAddress': 'میدان ونک، نبش داروخانه قانون',
    'postalCode': '1234567890',
    'number': 8,
    'unit': 8,
  },
  {
    'id': 5,
    'title': 'دفتر ترجمه 2',
    'geoLat': 35.7571450,
    'geoLong': 51.4104030,
    'fullAddress': 'میدان ونک، نبش داروخانه قانون',
    'postalCode': '1234567890',
    'number': 8,
    'unit': 8,
  },
  {
    'id': 6,
    'title': 'دفتر ترجمه 3',
    'geoLat': 35.7571450,
    'geoLong': 51.4104030,
    'fullAddress': 'میدان ونک، نبش داروخانه قانون',
    'postalCode': '1234567890',
    'number': 8,
    'unit': 8,
  },
  {
    'id': 7,
    'title': 'دفتر ترجمه 4',
    'geoLat': 35.7571450,
    'geoLong': 51.4104030,
    'fullAddress': 'میدان ونک، نبش داروخانه قانون',
    'postalCode': '1234567890',
    'number': 8,
    'unit': 8,
  }
];
