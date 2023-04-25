import 'package:address_module/ui/shared/colors.dart';
import 'package:address_module/ui/widgets/text/text_view.dart';
import 'package:flutter/material.dart';

/// help_methods contains methods that are helping us (it's like a toolbox Lol;) ) in Ui and Services

void snackBar(String text, context,
    {GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey, Color? color}) {
  if (scaffoldMessengerKey != null) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: TextView(
        text: text,
        color: color ?? white,
        size: 12,
      ),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: TextView(
        text: text,
        color: color ?? white,
        size: 12,
      ),
    ));
  }
}

String convertEnglishNumberToPersianNumber(String number) {
  var english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  var persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  for (var i = 0; i < english.length; i++) {
    number = number.replaceAll(english[i], persian[i]);
  }
  return number;
}

String convertPersianNumberToEnglishNumber(String number) {
  var english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  var persian = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  for (var i = 0; i < persian.length; i++) {
    number = number.replaceAll(persian[i], english[i]);
  }
  return number;
}
