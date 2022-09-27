import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; 

import '../res/color_manager.dart';
import '../res/values_manager.dart';

class CustomToast {
  static showToastNotification(
    msg, {
    Color? color,
    Color? textColor,
    ToastGravity? toastGravity,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: toastGravity ?? ToastGravity.BOTTOM,
      backgroundColor: color ?? ColorManager.primary,
      textColor: textColor ?? Colors.white,
      fontSize: AppSize.s16,
    );
  }

  static showSimpleToast(
      {required String msg, Color? color, Color? textColor}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color ?? ColorManager.primary,
      textColor: textColor ?? Colors.white,
      fontSize: AppSize.s16,
    );
  }
}
