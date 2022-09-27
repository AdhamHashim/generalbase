import "dart:async";
import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter/services.dart";

class AppLocalizations {
  final Locale locale;

  AppLocalizations({this.locale = const Locale("ar")});

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(locale: const Locale("ar"));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString("assets/lang/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key] ?? "";
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale: locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
// -------------------------------------------------------------------
// To translate strings
/*
    var local = AppLocalizations.of(context);
    local.translate(""),
,*/
// -------------------------------------------------------------------
// To change language
/*         
    var appLanguage = Provider.of<AppLanguage>(context, listen: false);
      if (appLanguage.appLocal != const Locale("ar")) {
        appLanguage.changeLanguage(const Locale("ar"));
      } else {
        appLanguage.changeLanguage(const Locale("en"));
      }
*/
// -------------------------------------------------------------------
