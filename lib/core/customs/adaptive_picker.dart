import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

import '../res/app_strings.dart';
import '../res/color_manager.dart';
import '../res/style_manager.dart';
import '../res/values_manager.dart';

class AdaptivePicker {
  static datePicker(
      {required BuildContext context,
      required Function(DateTime? date) onConfirm,
      required String title,
      DateTime? initial,
      DateTime? minDate}) async {
    if (Platform.isIOS) {
      _iosDatePicker(
        context,
        onConfirm,
        title,
        initial: initial,
        minDate: minDate,
      );
    } else {
      _androidDatePicker(
        context,
        onConfirm,
        initial: initial,
        minDate: minDate,
      );
    }
  }

  static _androidDatePicker(
      BuildContext context, Function(DateTime? date) onConfirm,
      {DateTime? initial, DateTime? minDate}) {
    showRoundedDatePicker(
      context: context,
      initialDate: initial ?? DateTime.now(),
      firstDate: minDate ?? DateTime.now().add(const Duration(days: -1)),
      lastDate: DateTime(2050),
      borderRadius: AppSize.s16,
      height: MediaQuery.of(context).size.height * .3,
      theme: ThemeData.light().copyWith(
        primaryColor: ColorManager.primary,
        backgroundColor: ColorManager.white,
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
    ).then(onConfirm);
  }

  static _iosDatePicker(
    BuildContext context,
    Function(DateTime? date) onConfirm,
    String title, {
    DateTime? initial,
    DateTime? minDate,
  }) {
    _bottomSheet(
      context: context,
      child: cupertinoDatePicker(context, onConfirm, title,
          initial: initial, minDate: minDate),
    );
  }

  static Widget cupertinoDatePicker(
      BuildContext context, Function(DateTime? date) onConfirm, String title,
      {DateTime? initial, DateTime? minDate}) {
    DateTime currentDate = DateTime.now();
    return SizedBox(
      height: MediaQuery.of(context).size.height * .35,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: mediumFont(color: ColorManager.primary)),
                ElevatedButton(
                  onPressed: () {
                    onConfirm(currentDate);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: AppSize.s0,
                    backgroundColor: ColorManager.white,
                  ),
                  child: Text(
                    AppString.adaptivePickerDone,
                    style: regularFont(color: ColorManager.primary),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: CupertinoDatePicker(
              initialDateTime: initial ?? DateTime.now(),
              onDateTimeChanged: (date) {
                currentDate = date;
              },
              minimumDate:
                  minDate ?? DateTime.now().add(const Duration(days: -1)),
              mode: CupertinoDatePickerMode.date,
            ),
          ),
        ],
      ),
    );
  }

  static timePicker(
      {required BuildContext context,
      required String title,
      required Function(DateTime? date) onConfirm}) async {
    if (Platform.isIOS) {
      _iosTimePicker(context, title, onConfirm);
    } else {
      _androidTimePicker(context, onConfirm);
    }
  }

  static _androidTimePicker(
      BuildContext context, Function(DateTime date) onConfirm) {
    var now = DateTime.now();
    showRoundedTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      theme: ThemeData(
        primaryColor: ColorManager.primary,
        backgroundColor: ColorManager.white,
        buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
      ),
    ).then(
      (time) => onConfirm(
        DateTime(now.year, now.month, now.day, time!.hour, time.minute),
      ),
    );
  }

  static _iosTimePicker(
      BuildContext context, String title, Function(DateTime? date) onConfirm) {
    _bottomSheet(
      context: context,
      child: cupertinoTimePicker(context, title, onConfirm),
    );
  }

  static Widget cupertinoTimePicker(
    BuildContext context,
    String title,
    Function(DateTime? date) onConfirm,
  ) {
    DateTime currentDate = DateTime.now();
    return SizedBox(
      height: MediaQuery.of(context).size.height * .35,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: mediumFont(color: ColorManager.primary),
                ),
                SizedBox(
                  height: AppSize.s20,
                  child: ElevatedButton(
                    onPressed: () {
                      onConfirm(currentDate);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: AppSize.s0, backgroundColor: ColorManager.white,
                    ),
                    child: Text(
                      AppString.adaptivePickerDone,
                      style: regularFont(color: ColorManager.primary),
                    ),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (date) {
                currentDate = date;
              },
            ),
          ),
        ],
      ),
    );
  }

  static _bottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    return showModalBottomSheet(
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s13),
          topRight: Radius.circular(AppSize.s13),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * .35,
        child: child,
      ),
    );
  }
}
