part of 'login_imports.dart';

class LoginData {
  static final LoginData _instance = LoginData._internal();

  LoginData._internal();

  factory LoginData({bool newInstance = false}) {
    if (newInstance) {
      return LoginData(newInstance: newInstance);
    } else {
      return _instance;
    }
  }

  final GenericBloc<int> data = GenericBloc<int>(0);
  final GenericBloc<LoginModel?> loginCubit = GenericBloc(null);

  void login() async {
    return (await GeneralRepository().login()).fold(
      (failur) => {
        if (failur.status == 0)
          {loginCubit.onUpdateInternetError(failur)}
        else
          {loginCubit.onUpdateError(failur)}
      },
      (data) => {loginCubit.onUpdateData(data)},
    );
  }
}
