import 'dart:async';

/// this is free mapToken of map.ir
const String mapTokenString =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6Ijc2NWE1NTgwNmNjNTM3MjJlODk1ZGQzNmYzYTA4MzIzNzRiNTY3NGI4NmUwYTQ2M2U3NzNmYWY4NDQxY2M4YTZlNzBkN2I5YWQzOTgyMzk5In0.eyJhdWQiOiIxNzAzNCIsImp0aSI6Ijc2NWE1NTgwNmNjNTM3MjJlODk1ZGQzNmYzYTA4MzIzNzRiNTY3NGI4NmUwYTQ2M2U3NzNmYWY4NDQxY2M4YTZlNzBkN2I5YWQzOTgyMzk5IiwiaWF0IjoxNjQ0NzM4OTk5LCJuYmYiOjE2NDQ3Mzg5OTksImV4cCI6MTY0NzI0NDU5OSwic3ViIjoiIiwic2NvcGVzIjpbImJhc2ljIl19.Ht8JNvY1f8tNYprSil-qV8jpyHH1165aN0ugTf6dRK5abwxCzqPA6kge6yt7xxYmNO3-urjLPfiU_PAqn_16xUt5yCUK8NQFQ6dT6qKHEJUg83t46AE90-S7_9weJ2yDV2lCzm4YpEmrlqeqOTNdBDPa7Jp2jkAeMFeNTIYPbz_7ubqLsvn2QbCpzhFjiaAmgudGWb11gaqGzamyOmqIYGpWHY-2QIEtexjVaK86F7JFvtakxuU1Kptmb6LRNmedKoWkah4VMg0Ify6T1PeDPPhleEDgXCeE9t8gCTIWKzeIRBV6BRmQHs6AxXEpoj4LJa4UUBWjhbCw6Py0Yo9g2g';

/// [CookieService] is a service for handling headers and cookies if needed.
class CookieService {
  String? _cookie;
  Map<String, String> defaultHeader = {'Content-type': 'application/json'};

  Future<Map<String, String>> header(
      {bool withContentType = false,
        bool mapToken = false}) async {
    var header = <String, String>{};

    if (_cookie != null) {
      header.addAll({"cookie": _cookie!});
    } else {
      if (await successfullyFetchedCookie()) {
        header.addAll({"cookie": _cookie!});
      }
    }
    if (mapToken) {
      header['x-api-key'] = mapTokenString;
    }
    if (withContentType) {
      header['Content-Type'] = 'application/json';
    }
    return header;
  }

  Future<bool> successfullyFetchedCookie() async {
    return _cookie != null;
  }
}
