import 'package:flutter/material.dart';
import 'package:address_module/enums/view_state.dart';
import 'package:address_module/generated/l10n.dart';
import 'package:address_module/locator.dart';
import 'package:address_module/services/navigation_service.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/blog.dart';
import 'package:address_module/ui/widgets/button/button.dart';
import 'package:address_module/ui/widgets/button/icon_button.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';

/// [CheckServiceEnabled] is a modal screen checking location service to enable
class CheckServiceEnabled extends StatelessWidget {
  final bool isDeniedForever;

  const CheckServiceEnabled({Key? key, this.isDeniedForever = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: width * 0.08, bottom: width * 0.0533),
          child: Stroke(
            height: width * 0.208,
            width: width * 0.208,
            radius: width * 0.1066,
            borderWidth: 0,
            backgroundColor:
                isDeniedForever ? primaryErrorColor : brandMainColor,
            child: isDeniedForever
                ? PermissionIcon(
                    color: white,
                    size: width * 0.0933,
                  )
                : LocationIcon(
                    color: white,
                    size: width * 0.0933,
                  ),
          ),
        ),
        TextView(
          text: isDeniedForever
              ? S.of(context).locationServicePermissionText
              : S.of(context).locationServiceText,
          color: primaryTextColor,
          size: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.08, vertical: width * 0.0266),
          child: TextView(
            text: isDeniedForever
                ? S.of(context).locationServicePermissionLongText
                : S.of(context).locationServiceLongText,
            color: primaryTextColor,
            textAlign: TextAlign.center,
            size: 16,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: width * 0.08,
              right: width * 0.04,
              left: width * 0.04,
              bottom: width * 0.08),
          child: RectAngleButton(
            state: ViewState.ready,
            height: width * 0.1333,
            width: width,
            nameOfButton: S.of(context).closeText,
            color: isDeniedForever ? primaryErrorColor : brandMainColor,
            onTap: () {
              locator<NavigationService>().goBack();
            },
          ),
        )
      ],
    );
  }
}
