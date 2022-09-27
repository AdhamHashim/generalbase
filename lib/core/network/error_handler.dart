// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

import 'models/failur.dart'; 

class ErrorHandler implements Exception {
  late Failur failur;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failur = _handleError(error);
    } else {
      failur = DataSource.DEFAULT.getFailur();
    }
  }
}

responseHandler(DioError error) {
  if (error.response != null &&
      error.response?.statusCode != null &&
      error.response?.statusMessage != null) {
    return Failur(
      error.response?.statusCode,
      error.response?.statusMessage,
    );
  } else {
    return DataSource.DEFAULT.getFailur();
  }
}

Failur _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.response:
      return responseHandler(error);
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailur();
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailur();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailur();
    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVER_TIMEOUT.getFailur();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailur();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  UNAUTHORISED,
  FORBIDDEN,
  NOT_FOUND,
  VALIDATION_ERROR,
  INTERNAL_SERVER_ERROR,
  NO_INTERNET_CONNECTION,
  CONNECT_TIMEOUT,
  RECIEVER_TIMEOUT,
  SEND_TIMEOUT,
  CASH_ERRROR,
  CANCEL,
  DEFAULT
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data
  static const int BAD_REQUEST = 400; // failur , api rejected request
  static const int UNAUTHORISED = 401; // failur , user is not authorised
  static const int FORBIDDEN = 403; // failur , api rejected request
  static const int NOT_FOUND = 404; // failur , not found
  static const int VALIDATION_ERROR = 422; // failur , validation error
  static const int INTERNAL_SERVER_ERROR = 500; // failur , server error

  // local status code
  static const int NO_INTERNET_CONNECTION = 0; //  no internet connection
  static const int CONNECT_TIMEOUT = -2; // connect timeout
  static const int RECIEVER_TIMEOUT = -3; // recieve timeout
  static const int SEND_TIMEOUT = -4; // send timeout
  static const int CASH_ERRROR = -5; // cash error
  static const int CANCEL = -6; // cansel
  static const int DEFAULT = -7; // unKnown error (status code)
}

class ResponseMessage {
  static const String SUCCESS = "success";
  static const String NO_CONTENT = "success";
  static const String BAD_REQUEST = "Error processing data,Try Again Later";
  static const String UNAUTHORISED =
      "user was unauthorised, The operation was not successful";
  static const String FORBIDDEN = "Error processing data,Try Again Later";
  static const String NOT_FOUND =
      "The operation was not successful,Try Again Later";
  static const String VALIDATION_ERROR = "Check Your Parameter,Try Again Later";

  static const String INTERNAL_SERVER_ERROR =
      "there is a problem with the server, please check with the application administration";

  // local status code
  static const String NO_INTERNET_CONNECTION =
      "please check your internet connection";
  static const String CONNECT_TIMEOUT = "Connect Timeout ,Try Again Later";
  static const String RECIEVER_TIMEOUT = "Recieve Timeout ,Try Again Later";
  static const String SEND_TIMEOUT = "Send Timeout ,Try Again Later";
  static const String CASH_ERRROR = "Cash error ,Try Again Later";
  static const String CANCEL = "Request Cancel ,Try Again Later";
  static const String DEFAULT = "Some Thing went Wrong ,Try Again Later";
}

extension DataSourceExtention on DataSource {
  Failur getFailur() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failur(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failur(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return Failur(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.UNAUTHORISED:
        return Failur(ResponseCode.UNAUTHORISED, ResponseMessage.UNAUTHORISED);
      case DataSource.FORBIDDEN:
        return Failur(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failur(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failur(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.CONNECT_TIMEOUT:
        return Failur(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.RECIEVER_TIMEOUT:
        return Failur(
            ResponseCode.RECIEVER_TIMEOUT, ResponseMessage.RECIEVER_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failur(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CASH_ERRROR:
        return Failur(ResponseCode.CASH_ERRROR, ResponseMessage.CASH_ERRROR);
      case DataSource.CANCEL:
        return Failur(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.DEFAULT:
        return Failur(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      case DataSource.NOT_FOUND:
        return Failur(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.VALIDATION_ERROR:
        return Failur(
            ResponseCode.VALIDATION_ERROR, ResponseMessage.VALIDATION_ERROR);
    }
  }
}
