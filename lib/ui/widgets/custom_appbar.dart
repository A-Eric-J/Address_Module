import 'package:flutter/material.dart';
import 'package:address_module/enums/appbar_state.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/button/button.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';

/// [CustomAppBar] is used for appBar but you can customize it more
class CustomAppBar extends StatelessWidget {
  final String title;
  final AppBarState? appBarState;
  final VoidCallback? closingOnTap;
  final VoidCallback? backingOnTap;
  final double? size;
  final EdgeInsetsGeometry? padding;

  const CustomAppBar(
      {Key? key,
      required this.title,
      this.appBarState,
      this.closingOnTap,
      this.backingOnTap,
      this.size,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
              vertical: width * 0.0266, horizontal: width * 0.04),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          button(appBarState, context),
          Expanded(
            child: TextView(
              text: title,
              size: size ?? 18,
              color: primaryTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget button(appBarState, context) {
    switch (appBarState) {
      case AppBarState.closing:
        return ClosingButton(
          onTap: closingOnTap ??
              () {
                locator<NavigationService>().goBack();
              },
        );

      case AppBarState.backing:
        return BackingButton(
          onTap: backingOnTap ??
              () {
                locator<NavigationService>().goBack();
              },
        );
    }
    return Container();
  }
}
