import 'package:flutter/material.dart';
import 'package:address_module/enums/gradient_type.dart';
import 'package:address_module/ui/shared/colors.dart';

/// We use a Container with  LinearGradient for some screens and widgets named
/// [MainGradient] that has different behaviours based on [GradientType], for now
/// we have just one item but you can add more in [GradientType]
class MainGradient extends StatelessWidget {
  final double? width;
  final double? height;
  final GradientType gradientType;
  final Widget child;

  const MainGradient({
    Key? key,
    this.width,
    this.height,
    required this.gradientType,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: this.width ?? width,
      decoration: boxDecoration(gradientType, width),
      child: child,
    );
  }

  BoxDecoration boxDecoration(GradientType gradientType, width) {
    switch (gradientType) {
      case GradientType.mapScreen:
        return BoxDecoration(
            gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            brandMainColor.withOpacity(0.3),
            brandMainColor.withOpacity(0.3),
            brandMainColor.withOpacity(0.3),
            brandMainColor.withOpacity(0.3),
          ],
          stops: const [0.5, 0.4, 0.3, 0.09],
        ));
      default:
        return const BoxDecoration();
    }
  }
}
