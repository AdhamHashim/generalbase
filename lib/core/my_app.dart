// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:generalbase/core/blocs/auth_cubit/auth_cubit.dart';
import 'package:generalbase/core/res/routes_manager.dart';
import 'package:provider/provider.dart';
import 'localization/app_language.dart';
import 'localization/app_loclaizations.dart';
import 'notifications/global_notifications.dart';
import 'res/theme_manager.dart';

ValueNotifier<Locale> locale = ValueNotifier(const Locale("ar", ""));

class Myapp extends StatefulWidget {
  final AppLanguage appLanguage;
  const Myapp({Key? key, required this.appLanguage}) : super(key: key);

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  void initState() {
    super.initState();
    initlocalNotification(context);
    requestPermissions();
    FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        if (message.data != null) {
          handleNotificationsTap(message.data.toString(), context);
        } else {
          handleNotificationsTap("${message.notification}", context);
        }
      }
    });
    FirebaseMessaging.onMessage.listen((event) {
      if (event.data != null) {
        showNotification(event, "${event.data}");
      } else {
        showNotification(event, "${event.notification}");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleNotificationsTap(event.data.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
      ],
      child: ChangeNotifierProvider<AppLanguage>(
        create: (context) => widget.appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          locale.value = model.appLocal;
          return MaterialApp(
            title: 'General_Base',
            debugShowCheckedModeBanner: false,
            theme: getAppTheme(),
            locale: model.appLocal,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en", "US"),
              Locale("ar", ""),
            ],
            initialRoute: Routes.splashRoute,
            onGenerateRoute: RouteGenerator.getRoutes,
          );
        }),
      ),
    );
  }
}
