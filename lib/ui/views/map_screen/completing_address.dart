import 'package:address_module/ui/widgets/textformfield/textformfield_item.dart';
import 'package:address_module/ui/widgets/views/address/custom_address_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:address_module/enums/address_state.dart';
import 'package:address_module/enums/appbar_state.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/generated/l10n.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/models/address.dart';
import 'package:address_module/providers/address_provider.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/shared/text.dart';
import 'package:address_module/ui/widgets/button/button.dart';
import 'package:address_module/ui/widgets/masked_text_controller.dart';
import 'package:provider/provider.dart';
import 'package:address_module/ui/extensions/widget_extension.dart';

/// [CompletingAddressScreen] when you what to create address or update it,
/// you should fill some information like Unit, No, Postal code and etc
class CompletingAddressScreen extends StatefulWidget {
  final Address address;
  final AddressState addressState;

  const CompletingAddressScreen(
      {Key? key, required this.address, required this.addressState})
      : super(key: key);

  @override
  State<CompletingAddressScreen> createState() =>
      _AddressRegistrationScreenState();
}

class _AddressRegistrationScreenState extends State<CompletingAddressScreen> {
  final newAddressFormKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();
  var isButtonEnable = false;

  TextEditingController titleAddressController =
      MaskedTextController(mask: '*', length: 15);
  TextEditingController fullNameAddressController =
      MaskedTextController(mask: '*', length: 100);
  TextEditingController numberAddressController =
      MaskedTextController(mask: '0', length: 5);
  TextEditingController unitAddressController =
      MaskedTextController(mask: '0', length: 5);
  TextEditingController postalCodeController =
      MaskedTextController(mask: '0', length: 10);

  @override
  void initState() {
    fullNameAddressController.text = widget.address.fullAddress!;
    if (widget.addressState == AddressState.updating) {
      numberAddressController.text = widget.address.number.toString();
      unitAddressController.text = widget.address.unit.toString();
      postalCodeController.text = widget.address.postalCode.toString();
      titleAddressController.text = widget.address.title!;
    }
    buttonEnable(
        titleAddressController.text,
        fullNameAddressController.text,
        numberAddressController.text,
        unitAddressController.text,
        postalCodeController.text);

    super.initState();
  }

  @override
  void dispose() {
    numberAddressController.dispose();
    unitAddressController.dispose();
    postalCodeController.dispose();
    titleAddressController.dispose();
    fullNameAddressController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Consumer<AddressProvider>(
            builder: (context, addressProvider, child) {
          return Column(
            children: [
              CustomAddressAppBar(
                title: S.of(context).addressText,
                appBarState: AppBarState.backing,
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Expanded(
                  child: NotificationListener(
                onNotification: (ScrollNotification scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification) {
                    if (scrollNotification.metrics.pixels < 0) {
                      _scrollController.jumpTo(0);
                    }
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: SizedBox(
                      width: width,
                      child: Form(
                        key: newAddressFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormFieldItem(
                              textController: titleAddressController,
                              labelText: titleAddressLabelText,
                              hintText: addressTitleHintText,
                              radius: width * 0.0266,
                              onChanged: (value) {
                                buttonEnable(
                                    value,
                                    fullNameAddressController.text,
                                    numberAddressController.text,
                                    unitAddressController.text,
                                    postalCodeController.text);
                              },
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            TextFormFieldItem(
                              textController: fullNameAddressController,
                              labelText: fullAddressLabelText,
                              hintText: fullAddressLabelText,
                              radius: width * 0.0266,
                              maxLines: 3,
                              onChanged: (value) {
                                buttonEnable(
                                    titleAddressController.text,
                                    value,
                                    numberAddressController.text,
                                    unitAddressController.text,
                                    postalCodeController.text);
                              },
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            TextFormFieldItem(
                              textController: numberAddressController,
                              labelText: numberAddressLabelText,
                              hintText: numberAddressHintText,
                              radius: width * 0.0266,
                              onChanged: (value) {
                                buttonEnable(
                                    titleAddressController.text,
                                    fullNameAddressController.text,
                                    value,
                                    unitAddressController.text,
                                    postalCodeController.text);
                              },
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            TextFormFieldItem(
                              textController: unitAddressController,
                              labelText: unitAddressLabelText,
                              hintText: unitAddressHintText,
                              radius: width * 0.0266,
                              onChanged: (value) {
                                buttonEnable(
                                    titleAddressController.text,
                                    fullNameAddressController.text,
                                    numberAddressController.text,
                                    value,
                                    postalCodeController.text);
                              },
                            ),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            TextFormFieldItem(
                              textController: postalCodeController,
                              labelText: postalCodeLabelText,
                              hintText: postalCodeHintText,
                              radius: width * 0.0266,
                              onChanged: (value) {
                                buttonEnable(
                                    titleAddressController.text,
                                    fullNameAddressController.text,
                                    numberAddressController.text,
                                    unitAddressController.text,
                                    value);
                              },
                            ),
                            SizedBox(
                              height: width * 0.0533,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              addRegistration(width, addressProvider),
            ],
          ).withBusyOverlay(addressProvider.addressViewState == ViewState.busy);
        }),
      ),
    );
  }

  void buttonEnable(String title, String fullAddress, String numberAddress,
      String unitAddress, String postalCode) {
    if (title.isNotEmpty &&
        fullAddress.isNotEmpty &&
        numberAddress.isNotEmpty &&
        unitAddress.isNotEmpty &&
        postalCode.isNotEmpty &&
        postalCode.length == 10) {
      setState(() {
        isButtonEnable = true;
      });
    } else {
      setState(() {
        isButtonEnable = false;
      });
    }
  }

  Widget addRegistration(width, AddressProvider addressProvider) {
    return Container(
      width: width,
      color: white,
      child: Padding(
        padding: EdgeInsets.only(
            right: width * 0.04,
            bottom: width * 0.0533,
            top: width * 0.0266,
            left: width * 0.04),
        child: RectAngleButton(
          state: ViewState.ready,
          height: width * 0.1466,
          width: width,
          nameOfButton: S.of(context).locationRegistrationText,
          color: isButtonEnable ? brandMainColor : primaryGray,
          onTap: isButtonEnable
              ? () {
                  preparingMyAddress(addressProvider);
                }
              : null,
        ),
      ),
    );
  }

  void preparingMyAddress(AddressProvider addressProvider) {
    var body = {};
    if (numberAddressController.text.isNotEmpty &&
        unitAddressController.text.isNotEmpty &&
        titleAddressController.text.isNotEmpty) {
      body = {
        'title': titleAddressController.text,
        'geoLat': widget.address.geoLat,
        'geoLong': widget.address.geoLong,
        'number': numberAddressController.text,
        'unit': unitAddressController.text,
        'fullAddress': fullNameAddressController.text,
        'postalCode': postalCodeController.text
      };
      if (widget.addressState == AddressState.updating) {
        body['id'] = widget.address.id;
        addressProvider.updateAddress(Address(
            body['geoLat'], body['geoLong'], body['fullAddress'],
            id: body['id'],
            title: body['title'],
            number: int.parse(body['number']),
            unit: int.parse(body['unit']),
            postalCode: body['postalCode']));
        locator<NavigationService>().goBack();
        locator<NavigationService>().goBack();
      } else {
        addressProvider.addNewAddress(
            Address(body['geoLat'], body['geoLong'], body['fullAddress'],

                ///  id must get from the response for adding to the provider
                ///  but as you know we do not have Api calling for sending
                ///  created address to the server but we use 10 as id
                id: 10,
                title: body['title'],
                number: int.parse(body['number']),
                unit: int.parse(body['unit']),
                postalCode: body['postalCode']));
        locator<NavigationService>().goBack();
        locator<NavigationService>().goBack();
      }
    }
  }

  /// this commented code could be the request sample to the server for adding and updating address
  void requestToServer(var body) async {
    // var response = (widget.addressState == AddressState.adding)
    //     ? await AddressService.addAddress(
    //     Provider.of(context, listen: false),
    //     Provider.of(context, listen: false),
    //     Provider.of(context, listen: false),
    //     body)
    //     : (widget.addressState == AddressState.updating)
    //     ? await AddressService.updateAddress(
    //     Provider.of(context, listen: false),
    //     Provider.of(context, listen: false),
    //     Provider.of(context, listen: false),
    //     body)
    //     : false;
    // if (response) {
    //   locator<NavigationService>().goBack();
    // }
  }
}
