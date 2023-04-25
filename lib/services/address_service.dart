import 'package:address_module/enums/view_state.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/providers/address_provider.dart';
import 'package:address_module/services/web_service.dart';

class AddressService {
  /// Some codes are commented because the Api is not real,
  /// we have put these commented codes here for your knowledge
  /// about how using address requests here
  static Future<void> getAddresses(
    WebService webService,
    AddressProvider addressProvider,
  ) async {
    addressProvider.setAddressViewState(ViewState.busy);
    // var response = await webService.getFunction(URLs.getAddressUrl);
    // if (response.responseStatus == ResponseStatus.success) {
    //   var responseBody = response.body as Map<String,dynamic>;
    //   if (responseBody.isNotEmpty) {
    //     var addresses = <Address>[];
    //     for(var address in responseBody['addresses']){
    //       addresses.add(Address.fromJson(address));
    //     }
    //     addressProvider.setAddresses(addresses);
    //
    //   }
    var addresses = <Address>[];
    for (var address in addressMock) {
      addresses.add(Address.fromJson(address));
    }
    addressProvider.setAddresses(addresses);
    addressProvider.setAddressViewState(ViewState.ready);
    // }  else {
    //   addressProvider.setAddressViewState(ViewState.failed);
    // }
  }
}
