// ignore_for_file: use_build_context_synchronously

part of 'utils_imports.dart';

class Utils {
  // Manipulate_Splash_Data
  static Future<void> manipulateSplashData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var strUser = prefs.get("user");
    if (strUser != null) {
      // UserModel data = UserModel.fromJson(json.decode("$strUser"));
      //here Store UserData in UserModel
      // context.read<UserCubit>().onUpdateUserData(model);
      changeLanguage(context);
      // Here Navigate TO HomeScreen
    } else {
      changeLanguage(context);
      // Here Navigate TO Login Or first screen in app

    }
  }
  // Delete1_Account
  static deleteAccount(BuildContext context) {
    clearSavedData();
    // AutoRouter.of(context).replaceAll([LoginRoute()]);
    // Here Navigate To LoginScreen
  }

  static Future<bool> manipulateLoginData(dynamic data) async {
    if (data != null) {
      // UserModel user = data;
      // await Utils.saveUserData(user);
      //here Store UserData in UserModel
      // context.read<UserCubit>().onUpdateUserData(model);
      //Here Navigate TO Home Screen

      return true;
    }
    return false;
  }

  static Future<bool> manipulateActiveData(
      BuildContext context, dynamic data) async {
    if (data != null) {
      // UserModel user = data;
      // user.lang = context.read<LangCubit>().state.locale.languageCode;
      // await Utils.saveUserData(user);
      //here Store UserData in UserModel
      // context.read<UserCubit>().onUpdateUserData(model);
      // Navigate To HomeScreens
      return true;
    }
    return false;
  }

  // static Future<void> saveUserData(UserModel model) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString("user", json.encode(model.toJson()));
  // }

  static void changeLanguage(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context, listen: false);
    if (appLanguage.appLocal != const Locale("ar")) {
      appLanguage.changeLanguage(const Locale("ar"));
    } else {
      appLanguage.changeLanguage(const Locale("en", "US"));
    }
  }

  // static UserModel getSavedUser({required BuildContext context}) {
  //   // return context.read<UserCubit>().state.model;
  //   return UserModel();
  // }

  static void clearSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static void launchURL({required String url}) async {
    if (!url.toString().startsWith("https")) {
      url = "https://$url";
    }
    final Uri toLaunch = Uri(scheme: 'https', host: url, path: 'headers/');
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $toLaunch';
    } else {
      CustomToast.showToastNotification("من فضلك تآكد من الرابط");
    }
  }

  static void launchWhatsApp(phone) async {
    String message = 'مرحبا بك';
    if (phone.startsWith("00966")) {
      phone = phone.substring(5);
    }
    var whatsAppUrl = "whatsapp://send?phone=+966$phone&text=$message";
    final Uri toLaunch =
        Uri(scheme: 'https', host: whatsAppUrl, path: 'headers/');

    if (kDebugMode) {
      print(whatsAppUrl);
    }
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $whatsAppUrl';
    }
  }

  static void launchYoutube({required String url}) async {
    final Uri toLaunch = Uri(scheme: 'https', host: url, path: 'headers/');
    if (Platform.isIOS) {
      final bool nativeAppLaunchSucceeded = await launchUrl(
        toLaunch,
        mode: LaunchMode.externalNonBrowserApplication,
      );
      if (!nativeAppLaunchSucceeded) {
        await launchUrl(
          toLaunch,
          mode: LaunchMode.inAppWebView,
        );
      }
    } else {
      if (!await launchUrl(
        toLaunch,
        mode: LaunchMode.externalApplication,
      )) {
        throw 'Could not launch $url';
      }
    }
  }

  static void shareFile() async {
    var filePath = '/path/to/file';
    final Uri uri = Uri.file(filePath);

    if (await File(uri.toFilePath()).exists()) {
      if (!await launchUrl(uri)) {
        throw 'Could not launch $uri';
      }
    }
  }

  static void callPhone({phone}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    launchUrl(emailLaunchUri);
  }

  static void sendMail(mail) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail,
    );
    launchUrl(emailLaunchUri);
  }

  static void shareApp(url) {
    CustomLoading.showLoadingDialog();
    Share.share(url).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  static Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  static Future<List<File>> getImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? result = await picker.pickMultiImage();
    if (result != null) {
      List<File> files = result.map((e) => File(e.path)).toList();
      return files;
    } else {
      return [];
    }
  }

  static Future<File?> getVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      File imageFile = File(video.path);
      return imageFile;
    }
    return null;
  }

  static void copToClipboard({
    required String text,
    required GlobalKey<ScaffoldState> scaffold,
  }) {
    if (text.trim().isEmpty) {
      CustomToast.showToastNotification("لا يوجد بيانات للنسخ");
      return;
    } else {
      Clipboard.setData(ClipboardData(text: text)).then((value) {
        CustomToast.showToastNotification("تم النسخ بنجاح");
      });
    }
  }
}
