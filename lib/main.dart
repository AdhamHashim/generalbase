import 'package:flutter/material.dart'; 
import 'core/localization/app_language.dart';
import 'core/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(Myapp(appLanguage: appLanguage));
}
