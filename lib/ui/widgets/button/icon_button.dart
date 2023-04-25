import 'package:flutter/material.dart';
import 'package:address_module/ui/shared/colors.dart';

/// Collection of IconButtons  that are using in this app

class RemoveIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  const RemoveIcon({Key? key, this.onTap, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.highlight_remove,
        size: size ?? width * 0.0446,
        color: color ?? removeIconColor,
      ),
    );
  }
}

class VisibilityPassword extends StatelessWidget {
  final VoidCallback? onTap;
  final double? size;
  final bool isVisible;

  const VisibilityPassword(
      {Key? key, this.onTap, this.size, required this.isVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: transparent,
      highlightColor: transparent,
      onTap: onTap,
      child: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        size: size ?? width * 0.0533,
        color: removeIconColor,
      ),
    );
  }
}

class BackingIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;

  final double? size;

  const BackingIcon({Key? key, this.onTap, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.arrow_back,
        size: size ?? width * 0.06,
        color: color ?? neutral500Color,
      ),
    );
  }
}

class ClosingIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final double? size;

  const ClosingIcon({Key? key, this.onTap, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.close,
        size: size ?? width * 0.06,
        color: neutral500Color,
      ),
    );
  }
}

class ReplayIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isFill;
  final Color? color;
  final double? size;

  const ReplayIcon(
      {Key? key, this.onTap, this.isFill = true, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        isFill ? Icons.replay_circle_filled : Icons.replay,
        size: size ?? width * 0.0533,
        color: color ?? brandMainColor,
      ),
    );
  }
}

class SearchIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const SearchIcon({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.search,
        color: citySearchTextFieldBorder,
        size: width * 0.064,
      ),
    );
  }
}

class LocationIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final bool isFill;
  final double? size;

  const LocationIcon(
      {Key? key, this.onTap, this.color, this.isFill = false, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        isFill ? Icons.location_on : Icons.location_on_outlined,
        color: color ?? brandOrangeColor,
        size: size ?? width * 0.064,
      ),
    );
  }
}

class AccessibilityIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const AccessibilityIcon({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Icon(
        Icons.accessibility,
        color: primaryDark,
        size: width * 0.06,
      ),
    );
  }
}

class MyLocationIcon extends StatelessWidget {
  final VoidCallback? onTap;

  const MyLocationIcon({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.my_location,
        color: primaryDark,
        size: width * 0.0533,
      ),
    );
  }
}

class PermissionIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  const PermissionIcon({Key? key, this.onTap, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.lock_outline,
        color: color ?? brandOrangeColor,
        size: size ?? width * 0.064,
      ),
    );
  }
}

class CircleRoundedIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;

  const CircleRoundedIcon({Key? key, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.circle_rounded,
        color: color ?? primaryDark,
        size: width * 0.032,
      ),
    );
  }
}
