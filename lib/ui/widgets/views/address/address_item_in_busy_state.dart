import 'package:flutter/material.dart';
import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/blog.dart';
import 'package:address_module/ui/widgets/widget_in_busy_state.dart';

/// [AddressItemInBusyState] is addressItem in busy state
class AddressItemInBusyState extends StatelessWidget {
  const AddressItemInBusyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.0133),
      child: Stroke(
        width: width,
        radius: width * 0.0266,
        backgroundColor: white,
        child: Container(
          width: width,
          margin: EdgeInsets.all(width * 0.032),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetInBusyState(
                height: width * 0.06,
                width: width * 0.2666,
                radius: width * 0.016,
              ),
              SizedBox(
                height: width * 0.0266,
              ),
              WidgetInBusyState(
                height: width * 0.0266,
                width: width * 0.6666,
                radius: width * 0.0266,
              ),
              SizedBox(
                height: width * 0.0266,
              ),
              WidgetInBusyState(
                height: width * 0.0266,
                width: width * 0.2666,
                radius: width * 0.0266,
              ),
              SizedBox(
                height: width * 0.0266,
              ),
              WidgetInBusyState(
                height: width * 0.0266,
                width: width * 0.2133,
                radius: width * 0.0266,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  WidgetInBusyState(
                    height: width * 0.1013,
                    width: width * 0.1013,
                    radius: width * 0.1013,
                  ),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  WidgetInBusyState(
                    height: width * 0.1013,
                    width: width * 0.1013,
                    radius: width * 0.1013,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
