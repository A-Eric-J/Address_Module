import 'package:flutter/material.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/button/icon_button.dart';
import 'package:address_module/ui/widgets/widget_in_busy_state.dart';

/// [MapSearchListItemInBusyState] is MapSearchListItem in busy state
class MapSearchListItemInBusyState extends StatelessWidget {
  const MapSearchListItemInBusyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(top: width * 0.03466),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.0213),
                child: CircleRoundedIcon(
                  color: firstShimmerColor,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.0213),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WidgetInBusyState(
                          height: width * 0.04,
                          width: width / 4,
                          radius: width * 0.0533),
                      SizedBox(
                        height: width * 0.04,
                      ),
                      WidgetInBusyState(
                          height: width * 0.04,
                          width: width,
                          radius: width * 0.0533)
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
