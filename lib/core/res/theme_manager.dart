import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

ThemeData getAppTheme() => ThemeData(
      // main Colors
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.lightprimary,
      primaryColorDark: ColorManager.darkprimary,
      disabledColor: ColorManager.border,
      splashColor: ColorManager.lightprimary, //ripple effect color
      // card Theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        elevation: AppSize.s4,
        shadowColor: ColorManager.shadow,
      ),

      // AppBar theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: AppSize.s4,
        color: ColorManager.primary,
        shadowColor: ColorManager.shadow,
        titleTextStyle: regularFont(
          color: ColorManager.white,
          fontSized: FontSize.s16,
        ),
      ),
      // button theme
      buttonTheme: ButtonThemeData(
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.shadow,
        disabledColor: ColorManager.border,
        shape: const StadiumBorder(),
      ),

      //dialog theme
      dialogTheme: DialogTheme(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s10)),
        titleTextStyle: mediumFont(
          color: ColorManager.secondry,
          fontSized: FontSize.s14,
        ),
        contentTextStyle: regularFont(
          color: ColorManager.secondry,
          fontSized: FontSize.s12,
        ),
      ),
      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: AppSize.s4,
          backgroundColor: ColorManager.primary,
          shadowColor: ColorManager.shadow,
          shape: const StadiumBorder(),
          textStyle: regularFont(
            color: ColorManager.white,
            fontSized: FontSize.s12,
          ),
        ),
      ),
      //  bottomNavigationBar  theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.primary,
        elevation: AppSize.s4,
        selectedLabelStyle: regularFont(
          color: ColorManager.white,
          fontSized: FontSize.s12,
        ),
      ),
      // text theme
      textTheme:   TextTheme(
        displayLarge: boldFont(color: ColorManager.primary),
        
      ),
      // TextFormField Theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: regularFont(
          color: ColorManager.secondry,
          fontSized: AppSize.s14,
        ),
        labelStyle: mediumFont(
          color: ColorManager.secondry,
          fontSized: AppSize.s14,
        ),
        errorStyle: regularFont(
          color: ColorManager.error,
          fontSized: AppSize.s14,
        ),
        // enable border Style
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: BorderSide(color: ColorManager.border, width: AppSize.s1),
        ),
        // focused border Style
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1),
        ),
        // error border Style
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),
        ),
        // focused Error Border Style
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1),
        ),
      ),
    );
