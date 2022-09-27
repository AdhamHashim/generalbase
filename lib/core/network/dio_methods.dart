import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../customs/custom_toast.dart';
import '../res/constans_manager.dart';
import 'dio_helper.dart';

class DioMethods {
  final RequestType requestType;
  DioMethods({
    required this.requestType,
  });

  final baseUrl = ConstansManager.base_url;
  final _dio = Dio();
  final _options = Options(
    receiveTimeout: 10000,
    sendTimeout: 10000,
    contentType: "application/json; charset=UTF-8",
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "*/*",
    },
  );
//-------------- POST REQUEST
  Future postFunc({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final FormData formData = FormData.fromMap(body);
    final response = await _dio.post(
      baseUrl + url,
      options: _options,
      data: formData,
    );

    return handelResponseData(response);
  }
//-------------- GET REQUEST

  Future getFunc({required String url}) async {
    final response =
        await _dio.get(baseUrl + url, options: _options).catchError((onError) {
      if (onError.type == DioErrorType.connectTimeout ||
          onError.type == DioErrorType.receiveTimeout) {
        debugPrint("debug : $onError");
      }
    });
    return handelResponseData(response);
  }
//-------------- PUT REQUEST

  Future putFunc({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final FormData formData = FormData.fromMap(body);
    final response =
        await _dio.put(baseUrl + url, data: formData, options: _options);
    return handelResponseData(response);
  }
//-------------- DELETE REQUEST

  Future deleteFunc({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final FormData formData = FormData.fromMap(body);
    final response =
        await _dio.delete(baseUrl + url, data: formData, options: _options);
    return handelResponseData(response);
  }
//-------------- PATCH REQUEST

  Future patchFunc({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final FormData formData = FormData.fromMap(body);
    final response =
        await _dio.patch(baseUrl + url, data: formData, options: _options);
    return handelResponseData(response);
  }
//-------------- HANDEL REQUEST DATA

  handelResponseData(Response response) {
    if (response.statusCode == 200 || response.statusCode == 204) {
      if (requestType != RequestType.get) {
        CustomToast.showSimpleToast(msg: response.data['msg']);
      }
      log(response.data['data']);
      return response.data;
    } else if (response.statusCode == 500) {
      log(response.data);
      return response;
    } else if (response.statusCode == 422 || response.statusCode == 400) {
      log(response.data);
      CustomToast.showSimpleToast(msg: response.data['msg']);
      return response;
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      log(response.data);
      return response;
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      log(response.data);
      return response;
    } else {
      log(response.data);
      return response;
    }
  }
}
