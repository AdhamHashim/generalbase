part of 'general_http_imports.dart';

class GeneralHttpMethods {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  late NetworkInfo _networkInfo;
  GeneralHttpMethods();

// login Error
  Future<Either<Failur, LoginModel>> login() async {
    if (await _networkInfo.isConected) {
      try {
        Response response = await DioHelper().dioNetworking(
          requestType: RequestType.post,
          url: ApiName.login,
          body: {},
        );
        if (response.statusCode==200) {
          return Right(LoginModel.fromJson(response.data));
        } else {
          return Left(Failur(response.statusCode, response.data['msg']));
        }
      } on DioError catch (error) {
        return Left(ErrorHandler.handle(error).failur);
      } catch (error) {
        return Left(DataSource.DEFAULT.getFailur());
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailur());
    }
  }
}
