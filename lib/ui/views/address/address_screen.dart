import 'package:address_module/ui/widgets/views/address/address_items_list.dart';
import 'package:address_module/ui/widgets/views/address/custom_address_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:address_module/const_values/assets.dart';
import 'package:address_module/const_values/route_paths.dart';
import 'package:address_module/enums/address_state.dart';
import 'package:address_module/enums/appbar_state.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/generated/l10n.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/providers/address_provider.dart';
import 'package:address_module/services/address_service.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/blog.dart';
import 'package:address_module/ui/widgets/custom_refresh_indicator.dart';
import 'package:provider/provider.dart';
import 'package:address_module/ui/extensions/widget_extension.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';

/// [AddressScreen] that contains list of addresses and a button for creating address and etc
class AddressScreen extends StatefulWidget {
  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreen();
}

class _AddressScreen extends State<AddressScreen> {
  final _scrollController = ScrollController();
  AddressProvider? _addressProvider;

  @override
  void initState() {
    _addressProvider = Provider.of(context, listen: false);
    if (_addressProvider!.addresses.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        requestToServer();
      });
    }
    super.initState();
  }

  void requestToServer() {
    AddressService.getAddresses(
      Provider.of(context, listen: false),
      Provider.of(context, listen: false),
    );
  }

  Future<void> refresh() async {
    requestToServer();
  }

  @override
  void dispose() {
    _addressProvider!.clearAddressList();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      body: SafeArea(
        child: Consumer<AddressProvider>(
            builder: (context, addressProvider, snapshot) {
          var emptyState =
              (addressProvider.addressViewState == ViewState.ready &&
                  addressProvider.addresses.isEmpty);
          var failedState =
              addressProvider.addressViewState == ViewState.failed;

          return Column(
            children: [
              CustomAddressAppBar(
                title: S.of(context).addressesText,
                appBarState: AppBarState.none,
              ),
              SizedBox(
                height: width * 0.04,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: S.of(context).addressListText,
                      size: 15,
                      color: textGray,
                      fontWeight: FontWeight.w500,
                    ),
                    Stroke(
                      backgroundColor: softBlue,
                      radius: width * 0.0213,
                      onTap: () => locator<NavigationService>().navigateTo(
                        RoutePaths.mapScreenPath,
                        arguments: {'addressState': AddressState.adding},
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.0266,
                            vertical: width * 0.0106),
                        child: TextView(
                          text: S.of(context).newAddressText,
                          size: 15,
                          color: brandMainColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.0266,
              ),
              failedState
                  ? PlaceHolderInFailedState(
                      refresh: refresh,
                      isExpanded: true,
                      pathPlaceHolder: Assets.emptyLocation,
                      isSvg: true)
                  : emptyState
                      ? PlaceHolderInEmptyState(
                          text: S.of(context).emptyMyAddressListText,
                          pathPlaceHolder: Assets.emptyLocation,
                          isSvg: true)
                      : Expanded(
                          child: CustomRefreshIndicator(
                            onRefresh: () => refresh,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Padding(
                                padding: EdgeInsets.only(top: width * 0.0266),
                                child: const AddressItemsList(
                                    hasHorizontalPadding: true),
                              ),
                            ),
                          ),
                        ),
            ],
          ).withBusyOverlay(addressProvider.addressViewState == ViewState.busy);
        }),
      ),
    );
  }
}
