part of 'general_http_imports.dart';

class GeneralRepository {
  late GeneralHttpMethods _generalHttpMethods;
  GeneralRepository() {
    _generalHttpMethods = GeneralHttpMethods();
  }

  Future<Either<Failur, LoginModel>> login() async =>
      _generalHttpMethods.login();
}
