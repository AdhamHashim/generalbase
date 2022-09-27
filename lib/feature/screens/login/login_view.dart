part of 'login_imports.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericBloc<LoginModel?>, GenericState<LoginModel?>>(
      bloc: LoginData().loginCubit,
      builder: (context, state) {
        if (state is GenericErrorState) {
          return Text(state.failur?.message ?? "");
        } else if (state is GenericInternetState) {
          return Text(state.failur?.message ?? "");
        } else if (state is GenericUpdateState) {
          return Text(state.data?.email ?? "");
        } else {
          return const Text("حدث خطا ما ");
        }
      },
    );
  }
}
