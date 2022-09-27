import 'dio_methods.dart';

enum ReturnType { model, list, type }

enum RequestType { get, post, put, patch, delete }

class DioHelper<T> {
  dioNetworking({
    required RequestType requestType,
    required String url,
    dynamic body,
  }) async {
    
    if (requestType == RequestType.get) {
      return await DioMethods(requestType: requestType).getFunc(url: url);
    } else if (requestType == RequestType.post) {
      return await DioMethods(requestType: requestType)
          .postFunc(url: url, body: body);
    } else if (requestType == RequestType.put) {
      return await DioMethods(requestType: requestType)
          .putFunc(url: url, body: body);
    } else if (requestType == RequestType.delete) {
      return await DioMethods(requestType: requestType)
          .deleteFunc(url: url, body: body);
    } else if (requestType == RequestType.patch) {
      return await DioMethods(requestType: requestType)
          .patchFunc(url: url, body: body);
    }
  }
}
