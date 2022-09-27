import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../res/app_strings.dart';
import '../res/color_manager.dart';
import '../res/values_manager.dart';

class CustomLoading {
  static showLoadingDialog() {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
      indicator: SpinKitCubeGrid(
        size: AppSize.s40,
        itemBuilder: (context, index) {
          return Container(
            height: AppSize.s10,
            width: AppSize.s10,
            margin: const EdgeInsets.all(AppMargin.m1),
            decoration: BoxDecoration(
              color: ColorManager.primary,
              shape: BoxShape.circle,
            ),
          );
        },
      ),
      status: AppString.customLoadingText,
    );
  }

  static showLoadingView({Color? color}) {
    return Center(
      child: SpinKitCubeGrid(
        color: color ?? ColorManager.primary,
        size: AppSize.s40,
      ),
    );
  }
}
