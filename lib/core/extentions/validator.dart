import 'package:flutter/material.dart';
import '../localization/app_loclaizations.dart';

extension Validator on String {
  String? noValidate() {
    return null;
  }

  String? validateEmpty(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? AppLocalizations.of(context).translate("fillField");
    }
    return null;
  }

  String? validatePassword(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? AppLocalizations.of(context).translate("fillField");
    } else if (length < 6) {
      return message ??
          AppLocalizations.of(context).translate("passValidation");
    }
    return null;
  }

  String? validateEmail(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? AppLocalizations.of(context).translate("fillField");
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this)) {
      return message ??
          AppLocalizations.of(context).translate("mailValidation");
    }
    return null;
  }

  String? validateEmailORNull(BuildContext context, {String? message}) {
    if (trim().isNotEmpty) {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(this)) {
        return message ??
            AppLocalizations.of(context).translate("mailValidation");
      }
    }
    return null;
  }

  String? validatePhone(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? AppLocalizations.of(context).translate("fillField");
    } else if (!RegExp(
                r'(^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)')
            .hasMatch(this) ||
        length < 10) {
      return message ??
          AppLocalizations.of(context).translate("phoneValidation");
    }
    return null;
  }

  String? validatePasswordConfirm(BuildContext context,
      {required String pass, String? message}) {
    if (trim().isEmpty) {
      return message ?? AppLocalizations.of(context).translate("fillField");
    } else if (this != pass) {
      return message ??
          AppLocalizations.of(context).translate("confirmValidation");
    }
    return null;
  }
}

extension ValidatorDrop<DataType> on DataType {
  String? validateDropDown(BuildContext context, {String? message}) {
    if (this == null) {
      return message ?? AppLocalizations.of(context).translate("fillField");
    }
    return null;
  }
}